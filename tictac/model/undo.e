note
	description: "This UNDO class is built to do all the undo function."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	UNDO

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			create undo_list.make (15)
			count:= 0
		end

feature -- Attributes
	undo_list: ARRAYED_STACK[ARRAY[INTEGER]]
	count: INTEGER

feature {NONE} -- Implementation

feature -- Access
	add(array: ARRAY[INTEGER])
	do
		undo_list.extend (array)
		count:= count + 1
	end

	undo: ARRAY[INTEGER]
	local
		l_array: ARRAY[INTEGER]
	do
		create l_array.make_from_array (undo_list.item)
		undo_list.remove
		count:= count - 1
		Result:= l_array
	end

feature -- Query
	can_undo: BOOLEAN
		-- will return true if we can undo again
		do
			Result:= not (undo_list.is_empty)
		end
end
