note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_UNDO
inherit
	ETF_UNDO_INTERFACE
		redefine undo end
create
	make
feature -- command
	undo
    	do
    		if not model.g.game_finished and not model.g.history.is_empty then
				if not model.g.history.before then
					model.g.history.item.reaction.call
					model.g.history.back
					model.set_report (model.out_report_success + model.g.turn.name + model.out_plays_next)
				end
			end

			etf_cmd_container.on_change.notify ([Current])
    	end
end
