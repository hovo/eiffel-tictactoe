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
	draw: BOOLEAN
	history: ARRAYED_LIST[OPERATION]
	turn: PLAYER

feature -- Constructor

	new_game
		--local
			--p1, p2: PLAYER
		do
			new_game_with_names("","")
		end

	new_game_with_names(n1: STRING; n2: STRING)
		local
			p1, p2: PLAYER
		do
			create p1.make_player (n1, 0, "X")
			create p2.make_player (n2, 0, "O")
			new_game_with_players(p1, p2)
		end

	new_game_with_players(p1: PLAYER; p2: PLAYER)
		do
			player_1 := p1
			player_2 := p2
			create game_board.make_board (3)
			create history.make (0)
			turn := player_1
			won := false
			draw := false
		end

feature -- Commands
	play_again
		do
			new_game_with_players(player_2, player_1)
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

	set_piece (i: INTEGER; piece: STRING)
		do
			game_board.board.put_i_th (piece, i)
		end

	add_move (i: INTEGER; piece: STRING)
		local
			o: OPERATION
		do
			-- ensure game is not finished before doing a move
			if not game_finished then
				create o
				o.execute (agent set_piece (i, piece), agent clear_piece (i))
				if not history.is_empty and not history.islast then
					history.remove_right
				end
				history.extend (o)
				history.finish

				update_game_status(i)
				if not game_finished then
					change_turn
				elseif won then
					increment_score(turn)
				end
				-- score stays the same in case of a draw
			end
		end

	clear_piece (i: INTEGER)
		do
			if not game_finished then
				game_board.board.put_i_th (game_board.empty_field, i)
				change_turn
			end
		end

	increment_score (p: PLAYER)
		do
			p.set_score (p.score + 1)
		end

	update_game_status (i: INTEGER)
		do
			won := game_board.check_row (i) or game_board.check_column (i) or game_board.check_diagonals(i)
			draw := game_board.is_board_full and not won
		end

feature -- Queries
	game_finished: BOOLEAN
		do
			Result := draw or won
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
