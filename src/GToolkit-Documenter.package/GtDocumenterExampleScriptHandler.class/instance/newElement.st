instance creation
newElement
	^ self scriptParameters
		at: 'show'
		ifPresent: [ :selector | 
			| exampleElement |
			exampleElement := GtPillarExampleElement
				withCode: (self scriptParameters includesKey: 'noCode') not.
			self scriptParameters
				at: 'height'
				ifPresent:
					[ :aHeight | exampleElement previewHeight: (Number readFromString: aHeight) ].
			exampleElement
				margin: (BlInsets all: 10);
				constraintsDo: [ :c | 
					c textFlow pushLine.
					c horizontal matchParent.
					c vertical fitContent ].
			exampleElement
				example: self exampleMethod gtExample
				showBlock: [ :returnValue | 
					| composite |
					composite := BlElement new
						constraintsDo: [ :c | 
							c vertical matchParent.
							c horizontal matchParent ].
					returnValue perform: selector asSymbol withArguments: {composite}.
					composite ].
			self scriptParameters
				at: 'expandedPreview'
				ifPresent: [ :isExpandedPreview | 
					isExpandedPreview asLowercase = 'true'
						ifTrue: [ exampleElement showPreview ] ].
			exampleElement ]
		ifAbsent: [ (GtExamplesStyler
				editorElementOnSourceCode: self exampleMethod sourceCode
				inClass: self exampleMethod methodClass)
				margin: (BlInsets all: 10) ]