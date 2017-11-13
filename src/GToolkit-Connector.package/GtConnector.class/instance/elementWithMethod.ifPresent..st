search
elementWithMethod: aMethod ifPresent: aBlock
	"Search for an editor opened on a given method
	and evaluate aBlock with it as argument if such an editor is found.
	Note: we don't make any assumptions on the type of aMethod object,
	it might be a CompiledMethod or any custom domain object that represents
	a method and implements a `=` comparison method"

	self
		assert: [ aMethod isNotNil ]
		description: [ 'Method must not be nil' ].

	self editorElements 
		detect: [ :anEditorElement | 
			anEditorElement userData
				at: #editedMethod
				ifPresent: [ :anEditedMethod | aMethod = anEditedMethod ]
				ifAbsent: [ false ] ]
		ifFound: [ :anEditorElement | aBlock cull: anEditorElement ]