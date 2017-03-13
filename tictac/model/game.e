note
	description: "Summary description for {GAME}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GAME

inherit
	ANY
		redefine
			out
		end

create
	new_game

feature -- Attributes
	game_board: BOARD
	player_1: PLAYER
	player_2: PLAYER
	won: BOOLEAN
	history: ARRAYED_LIST[OPERATION]
	turn: PLAYER
	--winning_piece: STRING
	-- History list for undo/redo

feature -- Constructor

	new_game
	-- Create a new game
		--require
		--	valid_name: check_player_name(p1) and check_player_name(p2)
		--	unique_names: p1 /~ p2

		do
			create player_1.make_player ("", 0, "X")
			create player_2.make_player ("", 0, "O")
			create game_board.make_board (3)
			create history.make (0)
			turn := player_1
			won := false
		end

feature -- Commands
	play_again
		do
			game_board.clear_board
			won := false
			-- TODO delete hostory list
			change_turn

		end

	update_players (p1: STRING; p2: STRING)
		do
			player_1.set_name (p1)
			player_2.set_name (p2)
		end

	change_turn
		do
			if turn.name ~ player_1.name then
				turn := player_2
			else
				turn := player_1
			end
		end

	add_move (i: INTEGER; piece: STRING)
		do
			-- ensure game is not finished before doing a move
			if not game_finished then
				game_board.board.put_i_th (piece, i)
				won := is_winning_move(i)
				if not won then
					change_turn
				else
					turn.set_score (turn.score + 1)
				end
			end
		end

	undo_move (i: INTEGER)
		do
			if not game_finished then
				game_board.board.put_i_th (game_board.empty_field, i)
				change_turn
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

	out: STRING
		do
			create Result.make_empty
			Result.append (game_board.out)
			Result.append ("%N  " + player_1.out)
			Result.append ("%N  " + player_2.out)
		end

feature -- Helper
	check_player_name (s: STRING): BOOLEAN
		-- Check if the first character contians A-z or a-z
		do
			Result := s.is_empty and not s.at (1).is_alpha
		end


end
