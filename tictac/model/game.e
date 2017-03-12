note
	description: "Summary description for {GAME}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GAME

create
	new_game

feature -- Attributes
	game_board: BOARD
	player_1: PLAYER
	player_2: PLAYER
	won: BOOLEAN
	--winning_piece: STRING
	-- History list for undo/redo

feature -- Constructor
	new_game (p1, p2: STRING)
	-- Create a new game
		require
			valid_name: check_player_name(p1) and check_player_name(p2)
			unique_names: p1 /~ p2

		do
			create player_1.make_player (p1, 0, "X")
			create player_2.make_player (p2, 0, "O")
			create game_board.make_board (3)
			won := false
		end

feature -- Commands
	add_move (i: INTEGER; piece: STRING)
		do
			-- ensure game is not finished before doing a move
			if not game_finished then
				game_board.board.put_i_th (piece, i)
				won := is_winning_move(i)
				-- TODO: keep track of who won, and update score
			end
		end

feature -- Queries
	game_finished: BOOLEAN
		do
			Result := game_board.is_board_full or won
		end

	is_winning_move (i: INTEGER): BOOLEAN
		local
			left_diaganal, right_diaganal: ARRAYED_LIST[INTEGER]
		do
			left_diaganal := game_board.get_diaganal (1)
			right_diaganal := game_board.get_diaganal (game_board.board_size)

			Result := game_board.check_row (i) or game_board.check_column (i) or
			          game_board.check_diaganal (i, left_diaganal) or game_board.check_diaganal (i, right_diaganal)
		end

	is_draw: BOOLEAN
		do
			Result := game_finished and not won
		end

feature -- Helper
	check_player_name (s: STRING): BOOLEAN
		-- Check if the first character contians A-z or a-z
		do
			Result := not s.is_empty and s.at (1).is_alpha
		end


end
