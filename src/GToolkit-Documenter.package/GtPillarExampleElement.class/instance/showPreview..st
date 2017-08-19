preview
showPreview: aBlockOrSymbol
	"Get return value of attached example and evaluate a given block
	with resulting object as an argument in order to transform it
	into a visual element to be opened as a preview"
	| aResultElement |

	self
		assert: [ previewElement hasParent not ]
		description: [ 'Can not show preview if it is already opened' ].

	self
		assert: [ previewElement hasChildren not ]
		description: [ 'Preview container must be empty' ].

	"we don't add resulting element directly, but instead put
	in a container that matches parent. This allows us to preserve
	layout constrains of resulting element untouched"
	aResultElement := aBlockOrSymbol value: self example returnValue.
	self
		assert: [ aResultElement isNotNil ]
		description: [ 'Resulting element must not be nil' ].

	previewElement addChild: aResultElement.
	self addChild: previewElement