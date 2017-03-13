note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_PLAY_AGAIN
inherit
	ETF_PLAY_AGAIN_INTERFACE
		redefine play_again end
create
	make
feature -- command
	play_again
    	do
    		model.reset
    		if model.g.player_1.name ~ "" and model.g.player_1.name ~ "" then
				model.set_report (model.out_finish_game + model.out_start_new_game)
			elseif not model.g.game_finished then
				model.set_report (model.out_finish_game + model.g.turn.name + model.out_plays_next)
			else
				model.g.play_again
				model.set_report (model.out_report_success + model.g.turn.name + model.out_plays_next)
			end

			etf_cmd_container.on_change.notify ([Current])
    	end

end
