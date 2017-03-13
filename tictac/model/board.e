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
		local
			x_occurance, o_occurance: INTEGER
		do
			across list as cursor loop
				if cursor.item  ~ "X" then
					x_occurance := x_occurance + 1
				end
				if cursor.item ~ "O" then
					o_occurance := o_occurance + 1
				end
			end

			Result := x_occurance = board_size or o_occurance = board_size

		end

	index_to_row (i: INTEGER): INTEGER
		-- Return the row from board index
		do
			Result := ((i - 1) // board_size) + 1
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
			c_index, hi: INTEGER
		do
			create column_array.make (0)
			c_index := index_to_col (i)
			hi := board_size - 1

			column_array.extend (board.at (c_index))

			across 1 |..| hi as cursor loop
				c_index := c_index +  board_size
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
			lo := hi - (board_size - 1)

			across lo |..| hi as c loop
				row_array.extend (board.at (c.item))
			end

			Result := row_array

		end

	get_diaganal (i: INTEGER): ARRAYED_LIST[INTEGER]
		local
			diaganal: ARRAYED_LIST[INTEGER]
			c, hi: INTEGER
		do
			create diaganal.make (0)
			hi := board_size - 1

			if i = 1 then
				c := i
				diaganal.extend (c)
				across 1 |..| hi as cursor loop
					c := c + (board_size + 1)
					diaganal.extend (c)
				end
			else
				c := board_size
				diaganal.extend (c)
				across 1 |..| hi as cursor loop
					c := c + (board_size - 1)
					diaganal.extend (c)
				end
			end

			Result := diaganal
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

	check_diaganal (i: INTEGER; list: ARRAYED_LIST[INTEGER] ): BOOLEAN
		-- Check for win in the diaganal
		local
			o_occurances, x_occurances: INTEGER
		do
			if list.has (i) then
				across list as cursor loop
					if board.at (cursor.item) ~ "X" then
						x_occurances := x_occurances + 1
					end
					if board.at (cursor.item) ~ "O" then
						o_occurances := o_occurances + 1
					end
				end
			end

			if x_occurances = 3 or o_occurances = 3 then
				Result := true
			end
		end

	check_diagonals(i: INTEGER): BOOLEAN
		local
			left_diaganal, right_diaganal: ARRAYED_LIST[INTEGER]
		do
			left_diaganal := get_diaganal (1)
			right_diaganal := get_diaganal (board_size)
			Result := check_diaganal (i, left_diaganal) or check_diaganal (i, right_diaganal)
		end

	out: STRING
		-- Print the board
		do
			create Result.make_empty

			across board as cursor loop

				if (cursor.cursor_index \\ board_size) = 1 then
					Result.append("  ")
				end

				Result.append (cursor.item)

				if (cursor.cursor_index \\ board_size) = 0 and cursor.cursor_index /= number_of_board_fields then
					Result.append ("%N")
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
