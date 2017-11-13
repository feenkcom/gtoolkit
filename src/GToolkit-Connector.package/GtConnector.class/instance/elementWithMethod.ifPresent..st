search
elementWithMethod: method ifPresent: aBlock
	self editorElements 
		detect: [ :each | 
			each userData
				at: #editedMethod
				ifPresent: [ :editedMethod | method = editedMethod ]
				ifAbsent: [ false ] ]
		ifFound: [ :element | ^ aBlock value: element ]