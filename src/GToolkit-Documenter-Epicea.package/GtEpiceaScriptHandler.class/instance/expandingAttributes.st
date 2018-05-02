private-styles
expandingAttributes
	| attributes expandingAttribute previewAttribute |
	attributes := super expandingAttributes.
	expandingAttribute := attributes first.
	previewAttribute := self newPreviewAttribute.
	expandingAttribute isExpanded: true.
	expandingAttribute createdAttributes: { previewAttribute }.
	^ attributes copyWith: previewAttribute.