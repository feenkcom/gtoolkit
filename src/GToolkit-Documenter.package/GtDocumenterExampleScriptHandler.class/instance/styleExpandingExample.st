private-styles
styleExpandingExample
	| previewAttribute attributesToAdd expandingAttribute |
	expandingAttribute := BrTextExpandButtonAttribute new
		attributesCreatingBlock: [ self newPreviewAttribute ].
	attributesToAdd := OrderedCollection with: expandingAttribute.
	self shouldBeExpanded
		ifTrue: [ previewAttribute := self newPreviewAttribute.
			attributesToAdd add: previewAttribute.
			expandingAttribute isExpanded: true.
			expandingAttribute createdAttributes: {previewAttribute} ].
	^ self targetText
		attributes: attributesToAdd
		from: self tokens last start
		to: self tokens last stop