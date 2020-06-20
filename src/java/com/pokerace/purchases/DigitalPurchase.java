package com.pokerace.purchases;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONObject;

public enum DigitalPurchase {
	PURCHASE_15K(	"15K Credits",						"$0.49", 	PurchaseType.CREDITS, 	"15,000", 	"WFHSRNTE6CBYL", false, 	false, 	"LegacyProductionCredits", 	false),
	PURCHASE_35K(	"35K Credits", 						"$0.99", 	PurchaseType.CREDITS, 	"35,000", 	"Y3GQ4ZYLLFM9S", false, 	true, 	"LegacyProductionCredits", 	false),
	PURCHASE_90K(	"90K Credits", 						"$1.99", 	PurchaseType.CREDITS, 	"90,000", 	"GVCYBHC9L584L", false, 	false, 	"LegacyProductionCredits", 	false),
	PURCHASE_500K(	"500K Credits", 					"$4.99", 	PurchaseType.CREDITS, 	"500,000", 	"E9JA3FDCSZXUC", true, 		false, 	"LegacyProductionCredits", 	false),
	
	V2_5M(	"5M Credits",								"$159.97", 	PurchaseType.CREDITS, 	"5,000,000","8LU5JF28Q6D2E", true, 	false, 	"ProductionCredits", 	false),
	V2_2M(	"2M Credits",								"$79.97", 	PurchaseType.CREDITS, 	"2,000,000","FC75BDHJT32E8", false, 	false, 	"ProductionCredits", 	false),
	V2_600K(	"600K Credits",							"$29.97", 	PurchaseType.CREDITS, 	"600,000", 	"T383F4R4G75FW", false, 	true, 	"ProductionCredits", 	false),
	V2_250K(	"250K Credits",							"$14.97", 	PurchaseType.CREDITS, 	"250,000", 	"L9VKRZQF2GR5G", false, 	false, 	"ProductionCredits", 	false),
	V2_110K(	"110K Credits",							"$7.97", 		PurchaseType.CREDITS, 	"110,000", 	"ZXKJL7F8VFAZ2", false, 	false, 	"ProductionCredits", 	false),
	V2_60K(	"60K Credits",								"$4.97", 		PurchaseType.CREDITS, 	"60,000", 	"YDN7RWCEEM7HW", false, 	false, 	"ProductionCredits", 	false),
	V2_20K(	"20K Credits",								"$1.97", 		PurchaseType.CREDITS, 	"20,000", 	"TNJ65QE92XZXY", false, 	false, 	"ProductionCredits", 	false),
	
	V2_10K_GOLD(	"10K Gold",							"$159.97", 	PurchaseType.GOLD, 		"10,000", 	"ZA6UVC6RBF4XS", true, 	false, 	"ProductionGold", 	false),
	V2_4K_GOLD(	"4K Gold",								"$79.97", 	PurchaseType.GOLD, 		"4,000", 	"CV9N68S9M8TDE", false, 	false, 	"ProductionGold", 	false),
	V2_1250_GOLD(	"1250 Gold",						"$29.97", 	PurchaseType.GOLD, 		"1250", 	"7VMPHPQX5XSPQ", false, 	true, 	"ProductionGold", 	false),
	V2_500_GOLD(	"500 Gold",							"$14.97", 	PurchaseType.GOLD, 		"500", 		"LWSNM5QTDLZME", false, 	false, 	"ProductionGold", 	false),
	V2_150_GOLD(	"150 Gold",							"$7.97", 		PurchaseType.GOLD, 		"150", 		"EFX6BSFK6J3UW", false, 	false, 	"ProductionGold", 	false),
	V2_65_GOLD(	"65 Gold",								"$4.97", 		PurchaseType.GOLD, 		"65", 		"JRWGJ747Z3LHC", false, 	false, 	"ProductionGold", 	false),
	V2_20_GOLD(	"20 Gold",								"$1.97", 		PurchaseType.GOLD, 		"20", 		"FBQX7A5F2SFZ2", false, 	false, 	"ProductionGold", 	false),
	
	STAGE_V2_5M(	"5M Credits",						"$159.97", 	PurchaseType.CREDITS, 	"5,000,000","4ND87CHBWC9DG", true, 	false, 	"StageCredits", 	true),
	STAGE_V2_2M(	"2M Credits",						"$79.97", 	PurchaseType.CREDITS, 	"2,000,000","Z8J6L7QJFRG8C", false, 	false, 	"StageCredits", 	true),
	STAGE_V2_600K(	"600K Credits",						"$29.97", 	PurchaseType.CREDITS, 	"600,000", 	"44TPH3ZGMWK48", false, 	true, 	"StageCredits", 	true),
	STAGE_V2_250K(	"250K Credits",						"$14.97", 	PurchaseType.CREDITS, 	"250,000", 	"3MXVKSBQLAH9L", false, 	false, 	"StageCredits", 	true),
	STAGE_V2_110K(	"110K Credits",						"$7.97", 		PurchaseType.CREDITS, 	"110,000", 	"M5TCL8X44P9JC", false, 	false, 	"StageCredits", 	true),
	STAGE_V2_60K(	"60K Credits",						"$4.97", 		PurchaseType.CREDITS, 	"60,000", 	"9Q77HDJP9SAM6", false, 	false, 	"StageCredits", 	true),
	STAGE_V2_20K(	"20K Credits",						"$1.97", 		PurchaseType.CREDITS, 	"20,000", 	"45VFQKVM5XV7W", false, 	false, 	"StageCredits", 	true),
	
	STAGE_V2_10K_GOLD(	"10K Gold",						"$159.97", 	PurchaseType.GOLD, 		"10,000", 	"WEZQKSUMZMJTQ", true, 	false, 	"StageGold", 	true),
	STAGE_V2_4K_GOLD(	"4K Gold",						"$79.97", 	PurchaseType.GOLD, 		"4,000", 	"2M4U2C3ML7536", false, 	false, 	"StageGold", 	true),
	STAGE_V2_1250_GOLD(	"1250 Gold",					"$29.97", 	PurchaseType.GOLD, 		"1250", 	"SH76Q5L3LD92G", false, 	true, 	"StageGold", 	true),
	STAGE_V2_500_GOLD(	"500 Gold",						"$14.97", 	PurchaseType.GOLD, 		"500", 		"AYQSALW4NYBWE", false, 	false, 	"StageGold", 	true),
	STAGE_V2_150_GOLD(	"150 Gold",						"$7.97", 		PurchaseType.GOLD, 		"150", 		"Q55758YJ8J2DE", false, 	false, 	"StageGold", 	true),
	STAGE_V2_65_GOLD(	"65 Gold",						"$4.97", 		PurchaseType.GOLD, 		"65", 		"U5DDTLSPSDD8N", false, 	false, 	"StageGold", 	true),
	STAGE_V2_20_GOLD(	"20 Gold",						"$1.97", 		PurchaseType.GOLD, 		"20", 		"A3M6RCH8XS3VS", false, 	false, 	"StageGold", 	true),
	
	STAGE_100K(		"Stage - 100K Credits", 			"AU$1.00", 		PurchaseType.CREDITS, 	"100,000", 	"7KAQ396A97XD4", true, 		true,	"StageTestCredits", 		false),
	SANDBOX_100K(	"Stage Sandbox - 100K Credits",		"AU$1.23", 		PurchaseType.CREDITS, 	"100,000", 	"K6S2J659PCFK4", true, 		true, 	"SandboxTestCredits", 		true),
	SANDBOX_100G(	"Stage Sandbox - 100 Gold",			"AU$4.56", 		PurchaseType.GOLD, 	  	"100", 		"K8UV7D48XJTD4", false, 	true, 	"SandboxTestGold",	 		true);
	
	private static final Map<String, List<DigitalPurchase>> GROUPS = new HashMap<>();
	private static final Map<String, DigitalPurchase> PRODUCTS = new HashMap<>();
	
	static {
		for (DigitalPurchase purchase : DigitalPurchase.values()) {
			List<DigitalPurchase> list = GROUPS.get(purchase.getProductGroup());
			if (list == null) {
				list = new ArrayList<>();
				GROUPS.put(purchase.getProductGroup(), list);
			}
			
			list.add(purchase);
			
			PRODUCTS.put(purchase.getPaypalId(), purchase);
		}
	}
	
	private String paypalName;
	private String cost;
	private String amount;
	private String paypalId;
	private boolean bestValue;
	private boolean mostPopular;
	private boolean sandbox;
	private PurchaseType purchaseType;
	private String productGroup;
	
	private DigitalPurchase(String paypalName, String cost, PurchaseType type, String awardedAmount, 
					String paypalId, boolean value, boolean popular, String group, boolean sandbox) {
		this.paypalName = paypalName;
		this.cost = cost;
		this.purchaseType = type;
		this.amount = awardedAmount;
		this.paypalId = paypalId;
		this.bestValue = value;
		this.mostPopular = popular;
		this.productGroup = group;
		this.sandbox = sandbox;
	}
	
	public String getCost() {
		return cost;
	}
	
	public double getCostDouble() {
		try {
			return Double.parseDouble(this.getCost().replaceAll("[^0-9\\.]", ""));
		}
		catch (Throwable e) {
			return 0.0;
		}
	}

	public String getAmount() {
		return amount;
	}
	
	public int getAmountInt() {
		try {
			return Integer.parseInt(this.getAmount().replaceAll("[^0-9]", ""));
		}
		catch (Throwable e) {
			return 0;
		}
	}

	public String getPaypalId() {
		return paypalId;
	}

	public boolean isBestValue() {
		return bestValue;
	}

	public boolean isMostPopular() {
		return mostPopular;
	}
	
	public PurchaseType getPurchaseType() {
		return purchaseType;
	}

	public String getProductGroup() {
		return productGroup;
	}
	
	public String getPaypalName() {
		return paypalName;
	}

	public boolean isSandbox() {
		return sandbox;
	}
	
	public String getPurchaseActionUrl() {
		return this.isSandbox() ? "https://www.sandbox.paypal.com/cgi-bin/webscr" : "https://www.paypal.com/cgi-bin/webscr";
	}
	
	public String getPurchaseValidationUrl() {
		return this.isSandbox() ? "https://ipnpb.sandbox.paypal.com/cgi-bin/webscr" : "https://ipnpb.paypal.com/cgi-bin/webscr";
	}

	@SuppressWarnings("unchecked")
	public JSONObject getJson() {
		JSONObject result = new JSONObject();
		
		if (this.isMostPopular()) {
			result.put("mostPopular", "true");
		}
		if (this.isBestValue()) {
			result.put("bestValue", "true");
		}
		
		result.put("purchaseAmount", this.getAmount());
		result.put("formattedCost", this.getCost());
		result.put("paypalId", this.getPaypalId());
		result.put("purchaseActionUrl", this.getPurchaseActionUrl());
		
		return result;
	}
	
	public static List<DigitalPurchase> getProductsForGroup(String group) {
		if (group != null && GROUPS.containsKey(group)) {
			return new ArrayList<>(GROUPS.get(group));
		}
		
		return Collections.emptyList();
	}
	
	public static DigitalPurchase getProductForPaypalId(String paypalId) {
		return PRODUCTS.get(paypalId);
	}
}
