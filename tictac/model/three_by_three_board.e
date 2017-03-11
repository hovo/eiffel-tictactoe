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
		require else
			valid_index: valid_button_number (button_number)
		do
			Result := board.at (button_number) ~ empty_field
		end

	is_board_full: BOOLEAN
		do
			Result := board.occurrences (empty_field) = 0
		end

	get_piece_at (button_number: INTEGER): STRING
		require else
			valid_index: valid_button_number (button_number)
		do
			Result := board.at (button_number)
		end

	out: STRING
		local
			i: INTEGER
		do
			create Result.make_empty
			across board as cursor loop
				i := cursor.cursor_index
				Result.append (cursor.item)
				if i = 3 or i = 6 then
					Result.append ("%N")
				end
			end
		end

feature -- Helpers
	valid_button_number (i: INTEGER): BOOLEAN
		do
			Result := i > 0 and i <= board_size
		end

	invariant
		board_size_equal: board_size = board.count

end
