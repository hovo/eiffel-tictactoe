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
    	do
			-- perform some update on the model state
			model.default_update
			etf_cmd_container.on_change.notify ([Current])
    	end

end
