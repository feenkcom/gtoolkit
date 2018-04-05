instance creation
newPreviewElement
	^ self scriptParameters
		at: 'show'
		ifPresent:
			[ :selector | self newPreviewElementFromSelector: selector ]
		ifAbsent: [ (GtExamplesStyler
				editorElementOnSourceCode: self exampleMethod sourceCode
				inClass: self exampleMethod methodClass)
				margin: (BlInsets all: 10) ]