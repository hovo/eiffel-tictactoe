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
	game_board: THREE_BY_THREE_BOARD
	player_1: PLAYER
	player_2: PLAYER
	-- History list for undo/redo

feature -- Constructor
	new_game (p1, p2: STRING)
	-- Create a new game
		require
			valid_name: check_player_name(p1) and check_player_name(p2)

		do
			create player_1.make_player (p1, 0, "X")
			create player_2.make_player (p2, 0, "O")
			create game_board.make_empty
		end

feature -- Helper
	check_player_name (s: STRING): BOOLEAN
		-- Check if the first character contians A-z or a-z
		do
			Result := not s.is_empty and s.at (1).is_alpha
		end


end
