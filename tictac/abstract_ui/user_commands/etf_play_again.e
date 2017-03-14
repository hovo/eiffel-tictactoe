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
		local
			m: STRING
			old_m: STRING
			error: BOOLEAN
			o: OPERATION
    	do
    		old_m := model.report.deep_twin
    		model.reset
			create m.make_empty

    		if not model.g.started then
				m := model.out_finish_game + ":" + model.out_start_new_game
				error := true

			elseif not model.g.game_finished then
				m := model.out_finish_game + ": => " + model.g.turn.name + model.out_plays_next
				error := true
			end

			create o
			if error then
				-- create a new op with error msg
				o.execute (agent set_model_report_error(m), agent set_model_report_error(old_m))
				model.g.add_to_history(o)
			else
				o.execute (agent playagain_action, agent playagain_reaction(old_m))
    		end

			etf_cmd_container.on_change.notify ([Current])
    	end

    	set_model_report_error (error: STRING)
			do
				model.set_report (error)
			end

		playagain_action
			do
				model.g.play_again
				model.set_report (model.out_report_success + ": => " + model.g.turn.name + model.out_plays_next)
			end

		playagain_reaction (old_m: STRING)
			do
				model.set_report (old_m)
			end

end
