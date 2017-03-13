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
			if not model.g.history.islast then
				model.g.history.last.action.call
				model.g.history.forth
			end

			etf_cmd_container.on_change.notify ([Current])
    	end

end
