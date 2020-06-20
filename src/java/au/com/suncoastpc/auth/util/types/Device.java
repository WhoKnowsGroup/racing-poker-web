package au.com.suncoastpc.auth.util.types;

import java.util.HashMap;
import java.util.Map;

import au.com.suncoastpc.auth.util.StringUtilities;

public enum Device {
	IOS("ios"),
	ANDROID("android");
	
	private static final Map<String, Device> DEVICE_MAP;
	
	static {
		DEVICE_MAP = new HashMap<String, Device>();
		
		for (Device device : Device.values()) {
			DEVICE_MAP.put(device.getKey(), device);
		}
	}

	private String key;
	
	private Device(String key) {
		this.key = key;
	}

	public String getKey() {
		return key;
	}
	
	public static Device deviceForKey(String key) {
		Device result = IOS;	//by default we assume iOS
		if (StringUtilities.isEmpty(key)) {
			return result;
		}
		
		key = key.toLowerCase();
		if (DEVICE_MAP.containsKey(key)) {
			result = DEVICE_MAP.get(key);
		}
		
		return result;
	}
}


