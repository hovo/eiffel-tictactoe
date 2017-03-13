note
	description: "Summary description for {REDO}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	REDO

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			create redo_list.make (15)
			count:= 0
		end

feature -- Attributes
	redo_list: ARRAYED_STACK[ARRAY[INTEGER]]
	count: INTEGER

feature {NONE} -- Implementation

feature -- Access
	add(array: ARRAY[INTEGER])
		do
			redo_list.extend (array)
			count:= count + 1
		end

	redo: ARRAY[INTEGER]
		local
			l_array: ARRAY[INTEGER]
		do
			create l_array.make_from_array (redo_list.item)
			redo_list.remove
			count:= count - 1
			Result:= l_array
		end

feature -- Query
	can_redo: BOOLEAN
		-- will return true if we can undo again
		do
			Result:= not (redo_list.is_empty)
		end

end
