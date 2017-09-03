streaming
showException: anException
	| string |
	string := String streamContents: [ :s | 
		anException signalerContext shortDebugStackOn: s ].
	self 
		expanding: [ 
			| text |
			text := BrRopedText string: string.
			text attributes: { BrTextForegroundAttribute new paint: Color red twiceDarker}.
			BrEditorElement new
				constraintsDo: [ :c |
					c horizontal matchParent.
					c textFlow pushLine.
					c vertical exact: 200 ];
				background: Color white;
				border: (BlBorder paint: Color veryLightGray width: 1);
				editor: (BrTextEditor new text: text) ];
		print: anException