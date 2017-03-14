note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_PLAY
inherit
	ETF_PLAY_INTERFACE
		redefine play end
create
	make
feature -- command
	play(player: STRING ; press: INTEGER_64)
		require else
			play_precond(player, press)
		local
			m: STRING
			old_m: STRING
			error: BOOLEAN
			o: OPERATION
    	do
    		old_m := model.report.deep_twin
    		model.reset
			create m.make_empty

			if model.g.game_finished then
				m := model.out_game_finished + ":" + model.out_start_new_game
				error := true

    		elseif model.g.player_1.name ~ "" or model.g.player_2.name ~ "" then
    			m := model.out_player_dne + ":" + model.out_start_new_game
				error := true

    		elseif model.g.player_1.name /~ player and model.g.player_2.name /~ player then
    			m := model.out_player_dne + ": => " + model.g.turn.name + model.out_plays_next
				error := true

    		elseif model.g.turn.name /~ player then
    			m := model.out_wrong_turn + ": => " + model.g.turn.name + model.out_plays_next
				error := true

    		elseif model.g.game_board.get_piece_at (press.as_integer_32) /~ model.g.game_board.empty_field then
    			m := model.out_button_taken + ": => " + model.g.turn.name + model.out_plays_next
				error := true

			end

			create o
			if error then
				-- create a new op with error msg
				o.execute (agent set_model_report_error(m), agent set_model_report_error(old_m))
			else
				o.execute (agent play_action(press), agent play_reaction(old_m, press))
    		end
    		model.g.add_to_history(o)

			etf_cmd_container.on_change.notify ([Current])
    	end

		set_model_report_error (error: STRING)
			do
				model.set_report (error)
			end

		play_action (press: INTEGER_64)
			local
				m: STRING
			do
				model.g.add_move (press.to_integer_32, model.g.turn.piece)
				if model.g.won then
	    			m := model.out_winner + ": => " + model.out_play_again_or_new
	    			model.set_report (m)

	    		elseif model.g.draw then
	    			m := model.out_game_ended_tie + ": => " + model.out_play_again_or_new
	    			model.set_report (m)

	    		else
	    			m := model.out_report_success + ": => " + model.g.turn.name + model.out_plays_next
	    			model.set_report (m)
	    		end
			end

		play_reaction (old_m: STRING; press: INTEGER_64)
			do
				model.g.clear_piece (press.to_integer_32)
				model.set_report (old_m)
			end
end
