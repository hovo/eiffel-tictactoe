note
	description: "Summary description for {THREE_BY_THREE_BOARD}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	THREE_BY_THREE_BOARD

inherit
	BOARD_TEMPLATE
		redefine
			out
		end

create
	make_empty

feature -- imp
	board: LIST[STRING]

	board_size: INTEGER = 9

	empty_field: STRING = "_"


feature -- Constructor
	make_empty
		-- Create an empty board
		do
			create {ARRAYED_LIST[STRING]} board.make (board_size)

			across 1 |..| board_size as i loop
				board.extend (empty_field)
			end

		ensure
			initialized:
				across board as cursor all
					cursor.item ~ empty_field and board.count = board_size
				end

		end


feature -- Queries
	is_board_empty: BOOLEAN
		do
			Result := board.occurrences (empty_field) = board_size
		end

	is_button_empty (button_number: INTEGER): BOOLEAN
		do
			Result := board.at (button_number) ~ empty_field
		end

	is_board_full: BOOLEAN
		do
			Result := board.occurrences (empty_field) = 0
		end

	out: STRING
		do
			create Result.make_empty
			across board as b loop
				Result.append (b.item + " ")
			end
		end

	invariant
		board_size_equal: board_size = board.count

end
