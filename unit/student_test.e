note
	description: "Summary description for {STUDENT_TEST}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	STUDENT_TEST

inherit
	ES_TEST

create
	make

feature {NONE}
	make
		do
			add_boolean_case (agent t1)
			add_boolean_case (agent t2)
			add_boolean_case (agent t3)
			add_boolean_case (agent t4)
		end

feature
	t1: BOOLEAN
		local
			b: THREE_BY_THREE_BOARD
		do
			comment ("t1: Test empty board creation routine")
			create b.make_empty
			sub_comment (b.out)
			Result := across b.board as it all it.item ~ "_" and b.board.count = 9 end
		end

	t2: BOOLEAN
		local
			b: THREE_BY_THREE_BOARD
		do
			comment ("t2: Test board empty routine")
			create b.make_empty
			Result := b.is_board_empty
		end

	t3: BOOLEAN
		local
			b: THREE_BY_THREE_BOARD
		do
			comment ("t3: Test board full routine")
			create b.make_empty
			Result := not b.is_board_full
		end

	t4: BOOLEAN
		local
			p: PLAYER
		do
			comment ("t4: Test player out and change score routine")
			create p.make_player ("Einstain", 0, "X")
			sub_comment (p.out)
			p.set_score (5)
			Result := p.score = 5
		end


end
