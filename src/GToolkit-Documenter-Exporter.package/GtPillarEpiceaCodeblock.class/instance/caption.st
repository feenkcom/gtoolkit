accessing-delegated
caption
	| aParagraph |
	aParagraph := super caption.
	aParagraph text ifEmpty: [ ^ PRParagraph with: (PRText content: self tokens epiceaParameterStringValue) ].
	^ aParagraph