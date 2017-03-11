note
	description: "Summary description for {BOARD_TEMPLATE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	BOARD_TEMPLATE

feature -- Queries
	is_board_empty: BOOLEAN
		-- Check if the board is empty
		deferred
		end

	is_button_empty (button_number: INTEGER): BOOLEAN
		-- Check if the specified button is empty
		deferred
		end

	is_board_full: BOOLEAN
		-- Check if the board is full
		deferred
		end

end
