package au.com.suncoastpc.auth.util;

/**
 * Holds constant values reference throughout the application.
 * 
 * @author Adam
 */
public class Constants {
	public static final String SESSION_USER_KEY = "suncoast.auth.user";
	
	public static final String SESSION_ACCOUNT_KEY = "user.current.account";
	
	public static final String ENTITY_MANAGER_REQUEST_KEY = "auth.entity.manager";
	
	public static final String REGISTRATION_EMAIL_SUBJECT = "Please confirm your account";
	
	public static final String RESET_PASSWORD_EMAIL_SUBJECT = "Your account password";
	
	public static final int TRUST_LEVEL_USER = 1;
	
	public static final int TRUST_LEVEL_ADMIN = 10000000;  //10-million
	
	public static final String DEFAULT_REQUEST_METHOD = "indexPage";
	
	public static final String PERSISTENT_LOGIN_COOKIE_NAME = "auth.login.token";
	
	public static final long PERSISTENT_LOGIN_COOKIE_LIFETIME = 1000 * 60 * 60 * 24 * 14; //2 weeks
	
	public static final String POST_LOGIN_URL_KEY = "nextUrl";
	
	public static final String ERROR_STATUS = "error";
	
	public static final String SUCCESS_STATUS = "success";
	
	public static final String GCM_PUSH_URL = "https://android.googleapis.com/gcm/send";
	
	public static final String GOOGLE_PLAY_BASE_URL = "https://www.googleapis.com/androidpublisher/v1.1/applications";
	
	public static final String GOOGLE_OAUTH_TOKEN_URL = "https://accounts.google.com/o/oauth2/token";
}
