visitor
visitMethodChange: aChange
	"Addition and Modification come here"
	self 
		behaviorNamed: aChange behaviorAffectedName
		ifPresent: [ :behavior | 
			^ behavior 
				compiledMethodAt: aChange methodAffectedSelector
				ifPresent: [ :method |
					self 
						printProtocol: method protocol
						sourceCode: method sourceCode ]
				ifAbsent: [ '' ] ].
	^ '' "If class is not present"