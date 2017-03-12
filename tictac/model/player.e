note
	description: "Summary description for {PLAYER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PLAYER

inherit
	ANY
		redefine
			out
		end

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

feature -- Commands
	set_name (new_name: STRING)
		do
			name := new_name
		end

	set_score (new_score: INTEGER)
		require
			vailid_score: new_score >= 0 and new_score > score
		do
			score := new_score

		ensure
			score_updated: score = old score + new_score
		end

feature -- Queires
	out: STRING
		local
			out_template: STRING
		do
			create Result.make_empty
			out_template := score.out + ": score for %"" + name + "%"" + " (as " + piece + ")"
			Result.append (out_template)
		end

end
