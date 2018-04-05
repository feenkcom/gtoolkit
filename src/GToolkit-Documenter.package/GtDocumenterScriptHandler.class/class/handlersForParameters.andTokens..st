enumerating
handlersForParameters: scriptParameters andTokens: tokens
	"Return handlers for a given script parameters.
	Handler with highest priority is first"
	<return: #Array of: #GtDocumenterScriptHandler>
	^ (self allSubclasses select: [ :eachClass | 
		eachClass handlesScriptWithParameters: scriptParameters andTokens: tokens ])
			sort: [ :a :b | a priority > b priority ]