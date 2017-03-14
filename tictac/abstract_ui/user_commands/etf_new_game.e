note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_NEW_GAME
inherit
	ETF_NEW_GAME_INTERFACE
		redefine new_game end
create
	make
feature -- command
	new_game(player1: STRING ; player2: STRING)
		require else
			new_game_precond(player1, player2)
    	do
    		--model.reset
    		if model.g.started then
    			if player1 ~ player2 then
    				model.set_report (model.out_unique_name + ": => " + model.g.turn.name + model.out_plays_next)
    			elseif not model.g.valid_player_name (player1) or not model.g.valid_player_name (player2) then
					model.set_report (model.out_name_start + ": => " + model.g.turn.name + model.out_plays_next)
				else
					model.g.new_game_with_names(player1, player2)
					model.set_report (model.out_report_success + ": => " + model.g.turn.name + model.out_plays_next)
    			end
    		else
    			if player1 ~ player2 then
    				model.set_report (model.out_unique_name + ":" + model.out_start_new_game)
	    		elseif not model.g.valid_player_name (player1) or not model.g.valid_player_name (player2) then
					model.set_report (model.out_name_start + ":" + model.out_start_new_game)
				elseif player1 ~ model.g.player_1.name and player2 ~ model.g.player_2.name then
					model.set_report (model.out_report_success + ": => " + model.g.turn.name + model.out_plays_next)
	    		else
	    			model.g.new_game_with_names(player1, player2)
					model.set_report (model.out_report_success + ": => " + model.g.turn.name + model.out_plays_next)
	    		end
    		end


			etf_cmd_container.on_change.notify ([Current])
    	end

end
