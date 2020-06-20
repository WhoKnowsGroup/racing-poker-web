package au.com.suncoastpc.auth.util.comparators;

import java.util.Comparator;

import com.pokerace.ejb.model.User;

public class UserLevelCompare implements Comparator<User> {
	@Override
	public int compare(User left, User right) {
		if (left.getPlayerLevelInt() == right.getPlayerLevelInt()) {
			//sort alphabetical
			return left.getNickname().compareToIgnoreCase(right.getNickname());
		}
		
		//sort descending, by level
		return -1 * (left.getPlayerLevelInt() - right.getPlayerLevelInt());
	}
}
