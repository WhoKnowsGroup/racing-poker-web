package com.pokerace.purchases;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONObject;

public enum ComboPurchase {
	SANDBOX_100_COMBO(	"Stage Sandbox - Combo 100", 	"AU$7.89",		"100,000",	"100",	"R5CSX3UWV42KE",	true,	true,	"StageComboPacks",	true),
	
	V2_5M_COMBO(		"5M Combo", 					"$223.96",	"5,000,000","10000","2D7G8P28MEJWE",	true,	false,	"ProductionCombos",	false),
	V2_2M_COMBO(		"2M Combo", 					"$111.96",	"2,000,000","4000",	"UDUZBVLXAQ7CU",	false,	false,	"ProductionCombos",	false),
	V2_600K_COMBO(		"600K Combo", 					"$41.96",	"600,000",	"1250",	"BXRDXYD8CALF6",	false,	true,	"ProductionCombos",	false),
	V2_250K_COMBO(		"250K Combo", 					"$20.96",	"250,000",	"500",	"D5RNWXS3X7RL2",	false,	false,	"ProductionCombos",	false),
	V2_110K_COMBO(		"100K Combo", 					"$11.16",	"110,000",	"150",	"HTU84DEEY9J52",	false,	false,	"ProductionCombos",	false),
	V2_60K_COMBO(		"60K Combo", 					"$6.96",		"60,000",	"65",	"9BXN9NQYQWRUL",	false,	false,	"ProductionCombos",	false),
	V2_20K_COMBO(		"20K Combo", 					"$2.76",		"20,000",	"20",	"FQKWCD7TVQS9C",	false,	false,	"ProductionCombos",	false),
	
	STAGE_V2_5M_COMBO(	"5M Combo", 					"$223.96",	"5,000,000","10000","4BS3SD7LULBYS",	true,	false,	"StageCombos",	true),
	STAGE_V2_2M_COMBO(	"2M Combo", 					"$111.96",	"2,000,000","4000",	"VL8RLUUJPB7TU",	false,	false,	"StageCombos",	true),
	STAGE_V2_600K_COMBO("600K Combo", 					"$41.96",	"600,000",	"1250",	"Z92DAD2EURWX2",	false,	true,	"StageCombos",	true),
	STAGE_V2_250K_COMBO("250K Combo", 					"$20.96",	"250,000",	"500",	"9BL9JCLBX5ZV6",	false,	false,	"StageCombos",	true),
	STAGE_V2_110K_COMBO("110K Combo", 					"$11.16",	"110,000",	"150",	"KQHXDHZ56BX2U",	false,	false,	"StageCombos",	true),
	STAGE_V2_60K_COMBO(	"60K Combo", 					"$6.96",		"60,000",	"65",	"GEZ3VRNRXK69S",	false,	false,	"StageCombos",	true),
	STAGE_V2_20K_COMBO(	"20K Combo", 					"$2.76",		"20,000",	"20",	"GGQ6QVCM4JK68",	false,	false,	"StageCombos",	true);
	
	private static final Map<String, List<ComboPurchase>> GROUPS = new HashMap<>();
	private static final Map<String, ComboPurchase> PRODUCTS = new HashMap<>();
	
	static {
		for (ComboPurchase purchase : ComboPurchase.values()) {
			List<ComboPurchase> list = GROUPS.get(purchase.getProductGroup());
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
	private String amountChips;
	private String amountGold;
	private String paypalId;
	private boolean bestValue;
	private boolean mostPopular;
	private String productGroup;
	private boolean sandbox;
	
	private ComboPurchase(String paypalName, String cost, String creditsAmount, String goldAmount, String paypalId, 
					boolean value, boolean popular, String group, boolean sandbox) {
		this.paypalName = paypalName;
		this.cost = cost;
		this.amountChips = creditsAmount;
		this.amountGold = goldAmount;
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

	public String getAmountChips() {
		return amountChips;
	}
	public String getAmountGold() {
		return amountGold;
	}
	
	public int getAmountChipsInt() {
		try {
			return Integer.parseInt(this.getAmountChips().replaceAll("[^0-9]", ""));
		}
		catch (Throwable e) {
			return 0;
		}
	}
	
	public int getAmountGoldInt() {
		try {
			return Integer.parseInt(this.getAmountGold().replaceAll("[^0-9]", ""));
		}
		catch (Throwable e) {
			return 0;
		}
	}
	
	public String getPaypalName() {
		return paypalName;
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
	
	public String getProductGroup() {
		return productGroup;
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
		
		result.put("purchaseAmountGold", this.getAmountGold());
		result.put("purchaseAmountChips", this.getAmountChips());
		result.put("formattedCost", this.getCost());
		result.put("paypalId", this.getPaypalId());
		result.put("purchaseActionUrl", this.getPurchaseActionUrl());
		
		return result;
	}
	
	public static List<ComboPurchase> getProductsForGroup(String group) {
		if (group != null && GROUPS.containsKey(group)) {
			return new ArrayList<>(GROUPS.get(group));
		}
		
		return Collections.emptyList();
	}
	
	public static ComboPurchase getProductForPaypalId(String paypalId) {
		return PRODUCTS.get(paypalId);
	}
}
