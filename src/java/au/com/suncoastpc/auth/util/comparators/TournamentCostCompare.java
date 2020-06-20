package au.com.suncoastpc.auth.util.comparators;

import java.util.Comparator;

import com.pokerace.ejb.model.Tournament;

public class TournamentCostCompare implements Comparator<Tournament> {

	@Override
	public int compare(Tournament left, Tournament right) {
		return (int)(left.getStartingCredits() - right.getStartingCredits());
	}

}
