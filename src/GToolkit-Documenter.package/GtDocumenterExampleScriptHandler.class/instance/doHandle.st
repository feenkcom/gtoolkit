private
doHandle
	| previewAttributeBlock exampleMethod attributesToAdd expandingAttribute previewAttribute |
	exampleMethod := Compiler evaluate: self exampleParameterValue.
	self targetText
		attributes: {(BrTextForegroundAttribute paint: Color gray)}
		from: self tokens first stop + 1
		to: self tokens last start - 1.
	previewAttributeBlock := [ BrTextAdornmentDynamicAttribute new
		beAppend;
		elementBlockWithErrorCatching: [ self scriptParameters
				at: 'show'
				ifPresent: [ :selector | 
					| exampleElement |
					exampleElement := GtPillarExampleElement
						withCode: (self scriptParameters includesKey: 'noCode') not.
					self scriptParameters at: 'height' ifPresent: [ :aHeight |
						exampleElement previewHeight: (Number readFromString: aHeight) ].
					exampleElement
						margin: (BlInsets all: 10);
						constraintsDo: [ :c | 
							c textFlow pushLine.
							c horizontal matchParent.
							c vertical fitContent ].
					exampleElement
						example: exampleMethod gtExample
						showBlock: [ :returnValue | 
							| composite |
							composite := BlElement new
								constraintsDo: [ :c | 
									c vertical matchParent.
									c horizontal matchParent ].
							returnValue
								perform: selector asSymbol
								withArguments: {composite}.
							composite ].
					self scriptParameters
						at: 'expandedPreview'
						ifPresent: [ :isExpandedPreview | (isExpandedPreview asLowercase = 'true') ifTrue: [ exampleElement showPreview ] ].
					exampleElement ]
				ifAbsent: [ (GtExamplesStyler
						editorElementOnSourceCode: exampleMethod sourceCode
						inClass: exampleMethod methodClass)
						margin: (BlInsets all: 10) ] ] ].
	expandingAttribute := BrTextExpandButtonAttribute new
		attributesCreatingBlock: previewAttributeBlock.
	attributesToAdd := OrderedCollection with: expandingAttribute.
	(self scriptParameters includesKey: 'expanded')
		ifTrue: [ previewAttribute := previewAttributeBlock value.
			attributesToAdd add: previewAttribute.
			expandingAttribute isExpanded: true.
			expandingAttribute createdAttributes: {previewAttribute} ].
	^ self targetText
		attributes: attributesToAdd
		from: self tokens last start
		to: self tokens last stop