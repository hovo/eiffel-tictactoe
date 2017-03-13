note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_REDO
inherit
	ETF_REDO_INTERFACE
		redefine redo end
create
	make
feature -- command
	redo
    	do
			if not model.g.game_finished and not model.g.history.is_empty then
				if not model.g.history.islast and model.g.history.valid_index(model.g.history.index + 1) then
					model.g.history.forth
					model.g.history.item.action.call
					model.set_report (model.out_report_success + model.g.turn.name + model.out_plays_next)
				end
			end

			etf_cmd_container.on_change.notify ([Current])
    	end
end
