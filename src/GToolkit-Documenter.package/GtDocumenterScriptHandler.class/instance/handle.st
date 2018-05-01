actions
handle
	"Handle (style) given script, represented by script parameters and tokens, in the target text"
	[ self doHandle ]
		on: Error
		do: [ :exception | 
			self ifDebugMode: [ exception pass ].
			self traceCr: exception ]