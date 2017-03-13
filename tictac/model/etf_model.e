note
	description: "A default business model."
	author: "Jackie Wang"
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_MODEL

inherit
	ANY
		redefine
			out
		end

create {ETF_MODEL_ACCESS}
	make

feature {NONE} -- Initialization
	make
		do
			create s.make_empty
			create g.new_game
			set_report(out_report_success + out_start_new_game)

		end

feature -- model attributes
	s : STRING
	i : INTEGER
	g : GAME

feature -- model operations
	default_update
		do

		end

	reset
		do
			report.wipe_out
		end


feature
	set_report (new_report: STRING)
		do
			report := new_report
		end

feature -- Out Messages
	report: STRING
		attribute
			create Result.make_empty
		end

	out_report_success: STRING
		attribute
			Result := "ok:  => "
		end

	out_start_new_game: STRING
		attribute
			Result := "start new game"
		end

	out_plays_next: STRING
		attribute
			Result := " plays next"
		end

	out_unique_name: STRING
		attribute
			Result := "names of players must be different:  => "
		end

	out_name_start: STRING
		attribute
			Result := "name must start with A-Z or a-z:  => "
		end

	out_wrong_turn: STRING
		attribute
			Result := "not this player's turn: => "
		end

	out_player_dne: STRING
		attribute
			Result := "no such player: => "
		end

	out_button_taken: STRING
		attribute
			Result := "button already taken: => "
		end

	out_winner: STRING
		attribute
			Result := "there is a winner: => play again or start new game"
		end

	out_finish_game: STRING
		attribute
			Result := "finish this game first: => "
		end

	out_game_finished: STRING
		attribute
			Result := "game is finished"
		end

	out_game_ended_tie: STRING
		attribute
			Result := "game ended in a tie"
		end



feature -- queries
	out : STRING
		do
			create Result.make_empty
			Result.append ("  " + report + "%N")
			Result.append (g.out)
		end

end




