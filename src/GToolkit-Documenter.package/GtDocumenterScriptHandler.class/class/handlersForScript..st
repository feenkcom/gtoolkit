enumerating
handlersForScript: aGtPillarScriptTokens
	"Return handlers for a given script parameters.
	Handler with highest priority is first"

	<return: #Array of: #GtDocumenterScriptHandler>
	^ (self allSubclasses
		select:
			[ :eachClass | eachClass handlesScript: aGtPillarScriptTokens ])
		sort: [ :a :b | a priority > b priority ]