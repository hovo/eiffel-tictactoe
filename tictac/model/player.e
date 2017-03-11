note
	description: "Summary description for {PLAYER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PLAYER

create
	make_player

feature -- Attributes
	name: STRING
	score: INTEGER
	piece: STRING

feature -- Constructor
	make_player (p_name: STRING; p_score: INTEGER; p_piece: STRING)
		-- Create a player
		do
			name := p_name
			score := p_score
			piece := p_piece
		end

end
