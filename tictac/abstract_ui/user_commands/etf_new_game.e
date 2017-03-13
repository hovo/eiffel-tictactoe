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
    		model.reset
    		if player1 ~ player2 then
    			model.set_report (model.out_unique_name + model.out_start_new_game)
    		elseif model.g.check_player_name (player1) or model.g.check_player_name (player2) then
				model.set_report (model.out_name_start + model.out_start_new_game)
    		else
    			model.g.update_players(player1, player2)
				model.set_report (model.out_report_success + model.out_plays_next)
    		end

			etf_cmd_container.on_change.notify ([Current])
    	end

end
