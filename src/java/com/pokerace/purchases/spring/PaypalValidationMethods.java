package com.pokerace.purchases.spring;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;
import java.util.Calendar;
import java.util.Enumeration;
import java.util.HashSet;
import java.util.Set;

import javax.ejb.EJB;
import javax.naming.InitialContext;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.lightcouch.CouchDbClient;
import org.springframework.web.servlet.ModelAndView;

import au.com.suncoastpc.auth.spring.base.BaseMethods;
import au.com.suncoastpc.auth.util.AccessUtils;
import au.com.suncoastpc.auth.util.StringUtilities;
import au.com.suncoastpc.util.CouchDBUtil;
import au.com.suncoastpc.util.types.CouchDatabase;

import com.google.gson.JsonObject;
import com.pokerace.ejb.iface.UserManager;
import com.pokerace.ejb.model.User;
import com.pokerace.purchases.ComboPurchase;
import com.pokerace.purchases.DigitalPurchase;
import com.pokerace.purchases.PurchaseType;

public class PaypalValidationMethods extends BaseMethods {
	private static final Logger LOG = Logger.getLogger(PaypalValidationMethods.class);
	
	private static final int HTTP_OK = 200;
	private static final String CUSTOM_FIELD_DELIMITER = "@@";
	
	private static final Set<String> ACCEPTED_PAYPAL_STATES = new HashSet<String>();
	
	static {
		ACCEPTED_PAYPAL_STATES.add("completed");
		ACCEPTED_PAYPAL_STATES.add("pending");
	}
	
	@EJB
	private UserManager userManager;

	private void initEjbs() {
		try {
			InitialContext ctx = new InitialContext();
			if (userManager == null) {
				userManager = (UserManager) ctx.lookup("java:global/Production_4/UserEJB!com.pokerace.ejb.iface.UserManager");
			}
		}
		catch (Throwable e) {
			e.printStackTrace();
		}
	}

	@Override
	protected void initServletContext(ServletContext sc) {
		initEjbs();
	}
	
	public ModelAndView verifyIPN(HttpServletRequest request, HttpServletResponse response) {
		String[] customParts = request.getParameter("custom").split(CUSTOM_FIELD_DELIMITER);
		
		String expectedProduct = customParts[1];
		User user = userManager.getUserDetails(customParts[0]);
		String paypalItemName = request.getParameter("item_name");
		String paypalStatus = request.getParameter("payment_status").toLowerCase();
		
		int qty = 1;
		try {
			qty = Integer.parseInt(request.getParameter("quantity"));
		}
		catch (Throwable ignored) {
			//ignored
		}
		
		//FIXME:  extract interface?
		DigitalPurchase purchase = DigitalPurchase.getProductForPaypalId(expectedProduct);
		ComboPurchase combo = ComboPurchase.getProductForPaypalId(expectedProduct);
		
		int numCredits = 0;
		int numBitlets = 0;
		double paymentAmount = 0.0;
		String requestUrl = null;
		if (purchase != null) {
			paymentAmount = purchase.getCostDouble();
			requestUrl = purchase.getPurchaseValidationUrl() + "?cmd=_notify-validate";
			numCredits = purchase.getPurchaseType() == PurchaseType.CREDITS ? purchase.getAmountInt() : 0;
			numBitlets = purchase.getPurchaseType() == PurchaseType.GOLD ? purchase.getAmountInt() : 0;
			
			if (! paypalItemName.equalsIgnoreCase(purchase.getPaypalName())) {
				LOG.warn("Paypal IPN validation failed for unknown item; itamName=" + paypalItemName + ", expectedItemName=" + purchase.getPaypalName() 
								+ ", status=" + paypalStatus + ", url=" + requestUrl);
				requestUrl = null;
			}
		}
		else if (combo != null) {
			paymentAmount = combo.getCostDouble();
			requestUrl = combo.getPurchaseValidationUrl() + "?cmd=_notify-validate";
			numCredits = combo.getAmountChipsInt();
			numBitlets = combo.getAmountGoldInt();
			
			if (! paypalItemName.equalsIgnoreCase(combo.getPaypalName())) {
				LOG.warn("Paypal IPN validation failed for unknown item; itamName=" + paypalItemName + ", expectedItemName=" + combo.getPaypalName() 
								+ ", status=" + paypalStatus + ", url=" + requestUrl);
				requestUrl = null;
			}
		}
		
		numCredits *= qty;
		numBitlets *= qty;
		paymentAmount *= qty;
		
		if (requestUrl != null && user != null) {
			synchronized(AccessUtils.getLockForEntity(user)) {
				//things look okay on our end; try to validate with paypal
				Enumeration<String> names = request.getParameterNames();
				while (names.hasMoreElements()) {
					String name = names.nextElement();
					String value = request.getParameter(name);
					
					requestUrl += "&" + name + "=" + StringUtilities.encodeURIComponent(value);
				}
				
				try {
					URL url = new URL(requestUrl);
					URLConnection conn = url.openConnection();
					conn.setDoOutput(true);
					conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
		
					String inputLine;
					BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
					while ((inputLine = in.readLine()) != null) {
						//09:05:00 [PaypalValidationMethods] WARN:  Paypal IPN validation failed; response=VERIFIED, status=Pending, url=https://ipnpb.sandbox.paypal.com/cgi-bin/webscr?cmd=_notify-validate&charset=windows-1252&payer_email=some1ne%40gmail.com&receiver_email=aroth.bigtribe%40gmail.com&payer_status=unverified&item_number=SS100K&transaction_subject=&residence_country=AU&test_ipn=1&txn_id=6ML238905M600654D&pending_reason=unilateral&payment_gross=&protection_eligibility=Ineligible&verify_sign=A4UA0KTwXQFnP1-Wt6MRcTTbGKHtAfrXKv8hUCERRPr4j3.wMakqwW5t&first_name=Adam&payment_date=09%3A04%3A55%20Jun%2026%2C%202018%20PDT&quantity=1&business=aroth.bigtribe%40gmail.com&method=verifyIPN&payment_status=Pending&custom=abmillard%40gmail.com%40%40K6S2J659PCFK4&last_name=Roth&item_name=Stage%20Sandbox%20-%20100K%20Credits&notify_version=3.9&mc_currency=AUD&payment_type=instant&txn_type=web_accept&payer_id=UD5AWW7G24PXJ&mc_gross=1.23&ipn_track_id=210a7f5ff1897]]
						
						if (inputLine.equalsIgnoreCase("verified") && ACCEPTED_PAYPAL_STATES.contains(paypalStatus)) {
							LOG.debug("Paypal IPN validation successful; user=" + user.getEmail() + ", product=" + expectedProduct); 
							
							CouchDbClient db1 = CouchDBUtil.getClient(CouchDatabase.PAYMENT_HISTORY);
							
							//everything checks out on both ends
							String paypalTxn = request.getParameter("txn_id");
							String desc = "Pay-pal";
							try {
								//updating the user entry
								double credits = user.getCredits();//Double.parseDouble(json.get("Credit").toString().replace("\"", ""));
								credits += numCredits;
								double bitlets = user.getBitlets();//Double.parseDouble(json.get("no_of_bitlets").toString().replace("\"", ""));
								bitlets += numBitlets;
								
								//update user's transaction list
								try {
									String payments = user.getPayments();//json.get("Payments").toString().replace("\"", "");
									if (StringUtilities.isEmpty(payments)) {
										payments = null;
									}
									if (payments.contains(paypalTxn)) {
										LOG.error("This transaction has already been validated; user=" + user.getEmail() + ", product=" + expectedProduct 
														+ ", txn=" + paypalTxn); 
										break;
									}
									
									payments += "," + paypalTxn;
									user.setPayments(payments);
								} catch (Exception e) {
									user.setPayments(paypalTxn);
								}
								
								//update credit and bitlet amounts
								user.setCredits((long)credits);
								user.setBitlets(bitlets);
								
								userManager.update(user);
								
								//log the transaction
								JsonObject json1 = new JsonObject();
								Calendar cal = Calendar.getInstance();
								
								json1.addProperty("_id", paypalTxn);
								json1.addProperty("Username", user.getEmail());
								json1.addProperty("Payment_amount", paymentAmount);
								json1.addProperty("Status", "confirmed");
								json1.addProperty("Date", (cal.get(Calendar.DAY_OF_MONTH)) + "/" + (cal.get(Calendar.MONTH) + 1) + "/" + cal.get(Calendar.YEAR));
								json1.addProperty("Credits_added", numCredits);
								json1.addProperty("Description", desc);
								json1.addProperty("Total_credits", credits);
								json1.addProperty("Bitlets", numBitlets);
	
								db1.save(json1);
							} catch (Exception e) {
								LOG.error("Failed to save Paypal transaction record!", e);
							}
						}
						else {
							LOG.warn("Paypal IPN validation failed; response=" + inputLine + ", status=" + paypalStatus + ", url=" + requestUrl);
						}
					}
					in.close();
				}
				catch (Throwable paypalError) {
					LOG.error("Paypal IPN validation threw exception!", paypalError);
				}
			}
		}
		
		response.setStatus(HTTP_OK);
		return null;
	}
}
