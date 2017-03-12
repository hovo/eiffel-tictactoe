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
	board_size: INTEGER
	empty_field: STRING = "_"
	board: ARRAYED_LIST[STRING]

feature
	make_board (b_size: INTEGER)
		-- Create board of specfied size
		do
			number_of_board_fields := b_size * b_size
			board_size := b_size
			create board.make (number_of_board_fields)

			across 1 |..| number_of_board_fields as i loop
				board.extend (empty_field)
			end

		ensure
			initialized: is_board_empty
		end

feature -- Queries
	is_board_empty: BOOLEAN
		-- Check if the board is empty
		do
			Result := board.occurrences (empty_field) = number_of_board_fields
		end

	is_button_empty (button_number: INTEGER): BOOLEAN
		-- Check if the specified field is empty
		require
			valid_index: valid_button_number (button_number)
		do
			Result := board.at (button_number) ~ empty_field
		end

	is_board_full: BOOLEAN
		-- Check if board is full
		do
			Result := board.occurrences (empty_field) = 0
		end

	get_piece_at (button_number: INTEGER): STRING
		-- Retuns "X" or "O" at specified indiex
		require
			valid_index: valid_button_number (button_number)
		do
			Result := board.at (button_number)
		end

	is_array_element_same (list: ARRAYED_LIST[STRING]): BOOLEAN
		do
			if list.occurrences ("X") = board_size or list.occurrences ("O") = board_size then
				Result := true
			else
				Result := false
			end
		end

	index_to_row (i: INTEGER): INTEGER
		-- Return the row from board index
		do
			Result := (i - 1) // board_size
		end

	index_to_col (i: INTEGER): INTEGER
		-- Return the column from board index
		do
			Result := i - (index_to_row (i) - 1) * board_size
		end

	get_col (i: INTEGER): ARRAYED_LIST[STRING]
		-- returns list of elements in column c
		local
			column_array: ARRAYED_LIST[STRING]
			c, c_index: INTEGER
		do
			create column_array.make (0)
			c := index_to_col (i)

			across 1 |..| board_size as cursor loop
				c_index := c + cursor.item * board_size
				column_array.extend (board.at (c_index))
			end

			Result := column_array
		end

	get_row (i: INTEGER): ARRAYED_LIST[STRING]
		-- returns list of elements in row r
		local
			row_array: ARRAYED_LIST[STRING]
			lo, hi: INTEGER
		do
			create row_array.make (0)
			hi := index_to_row (i) * board_size
			lo := hi - board_size

			across lo |..| hi as c loop
				row_array.extend (board.at (c.item))
			end

			Result := row_array

		end

	check_row (i: INTEGER): BOOLEAN
		-- Check for win in row
		do
			Result := is_array_element_same (get_row (i))
		end

	check_column (i: INTEGER): BOOLEAN
		-- Check for win in the column
		do
			Result := is_array_element_same (get_col (i))
		end

	check_diaganal (i: INTEGER): BOOLEAN
		-- Check for win in the diaganal
		do
			-- TODO
			Result := true
		end

	out: STRING
		-- Print the board
		do
			create Result.make_empty

			across board as cursor loop

				Result.append (cursor.item)

				if cursor.cursor_index /= number_of_board_fields then
					Result.append ("%N")
				end

			end
		end

feature -- Commands
	clear_board
		-- Clear the board
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
