private-styles
expandingAttributes
	| attributes expandingAttribute |
	attributes := super expandingAttributes.
	expandingAttribute := attributes first.
	^ self shouldBeExpanded
		ifFalse: [ attributes ]
		ifTrue: [ | previewAttribute |
			previewAttribute := self newPreviewAttribute.
			expandingAttribute isExpanded: true.
			expandingAttribute createdAttributes: { previewAttribute }.
			attributes copyWith: previewAttribute ].