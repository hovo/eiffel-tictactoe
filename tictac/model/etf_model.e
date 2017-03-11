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
			-- Initialization for `Current'.
		do
			create s.make_empty
			i := 0
		end

feature -- model attributes
	s : STRING
	i : INTEGER

feature -- model operations
	default_update
			-- Perform update to the model state.
		do
			i := i + 1
		end

	reset
			-- Reset model state.
		do
			make
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
			Result := "ok"
		end

	out_unique_name: STRING
		attribute
			Result := "names of players must be different"
		end

	out_name_start: STRING
		attribute
			Result := "names of players must be different"
		end

	out_wrong_turn: STRING
		attribute
			Result := "not this player's turn"
		end

	out_player_dne: STRING
		attribute
			Result := "no such player"
		end

	out_button_taken: STRING
		attribute
			Result := "button already taken"
		end

	out_winner: STRING
		attribute
			Result := "button already taken"
		end

	out_finish_game: STRING
		attribute
			Result := "finish this game first"
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
			create Result.make_from_string ("  ")
			Result.append ("System State: default model state ")
			Result.append ("(")
			Result.append (i.out)
			Result.append (")")
		end

end




