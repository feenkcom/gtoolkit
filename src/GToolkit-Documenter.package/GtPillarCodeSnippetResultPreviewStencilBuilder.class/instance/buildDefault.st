api - instantiation
buildDefault
	| anOutputText |
	
	anOutputText := ('(outs at: ' , self codeSnippet index asString , ')') asRopedText.
	anOutputText monospace.
	anOutputText foreground: (self codeSnippet isException
		ifTrue: [ Color red ]
		ifFalse: [ Color gray ]).

	^ GtPillarCodeSnippetResultPreviewStencil new
		result: self codeSnippet value;
		outputInformation: anOutputText