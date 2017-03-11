note
	description: "Summary description for {BOARD}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BOARD

inherit
	ANY
		redefine
			out
		end

create
	make_board

feature -- Attributes
	number_of_board_fields: INTEGER
	empty_field: STRING = "_"
	board: ARRAYED_LIST[STRING]

feature
	make_board (board_size: INTEGER)
		-- Create board of specfied size
		do
			number_of_board_fields := board_size * board_size
			create board.make (number_of_board_fields)

			across 1 |..| number_of_board_fields as i loop
				board.extend (empty_field)
			end

		ensure
			initialized: is_board_empty
		end

feature -- Queries
	is_board_empty: BOOLEAN
		do
			Result := board.occurrences (empty_field) = number_of_board_fields
		end

	is_button_empty (button_number: INTEGER): BOOLEAN
		require
			valid_index: valid_button_number (button_number)
		do
			Result := board.at (button_number) ~ empty_field
		end

	is_board_full: BOOLEAN
		do
			Result := board.occurrences (empty_field) = 0
		end

	get_piece_at (button_number: INTEGER): STRING
		require
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

feature -- Commands
	clear_board
		do
			if not is_board_empty then
				across board as cursor loop
					board.replace (empty_field)
				end
			end

		end

feature -- Helpers
	valid_button_number (i: INTEGER): BOOLEAN
		do
			Result := i > 0 and i <= number_of_board_fields
		end

	invariant
		board_size_equal: number_of_board_fields = board.count

end
