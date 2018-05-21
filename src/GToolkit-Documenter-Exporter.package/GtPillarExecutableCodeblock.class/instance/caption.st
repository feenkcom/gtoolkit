accessing-delegated
caption
	| aParagraph |
	aParagraph := super caption.
	aParagraph text ifEmpty: [ 
		^ PRParagraph with: (PRText content: 'Executable script') ].
	^ aParagraph