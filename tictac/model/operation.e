note
	description: "Summary description for {OPERATION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	OPERATION

feature
	execute (a_action: like action; a_reaction: like reaction)
		do
			action := a_action
			reaction := a_reaction
			action.call
		end

	action: ROUTINE[ANY, TUPLE]
		attribute
			Result := (agent do end)
		end

	reaction: ROUTINE[ANY, TUPLE]
		attribute
			Result := (agent do end)
		end

end
