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
			model.g.history.last.reaction.call
			if not model.g.history.isfirst then
				model.g.history.back
			end
			
			etf_cmd_container.on_change.notify ([Current])
    	end

end
