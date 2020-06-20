package au.com.suncoastpc.auth.util;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;

import com.pokerace.ejb.model.User;
import com.pokerace.ejb.model.base.BasicEntity;

public class AccessUtils {
	private static final int NUM_LOCKS = 1024;
	private static final Logger LOG = Logger.getLogger(AccessUtils.class);
	private static final CircularArray<Long> LOCKS = new CircularArray<Long>(NUM_LOCKS);
	
	public static Object getAccountLock(HttpServletRequest request) {
		User account = getCurrentUser(request);
		if (account == null) {
			//there's no account we can get a lock for yet; probably this means we are dealing with an anonymous user who should not require locking anyways, just return any random thing
			return Math.random();
		}
		Long lock = new Long(account.getId());
		if (! LOCKS.contains(lock)) {
			LOCKS.add(lock);
		}
		
		return LOCKS.instanceEqualTo(lock);
	}
	
	public static Object getLockForEntity(BasicEntity entity) {
		Long lock = new Long(entity.getId());
		if (! LOCKS.contains(lock)) {
			LOCKS.add(lock);
		}
		
		return LOCKS.instanceEqualTo(lock);
	}
	
	public static User getCurrentUser(HttpServletRequest request) {
		 return (User)request.getSession().getAttribute(Constants.SESSION_USER_KEY);
	}
}
