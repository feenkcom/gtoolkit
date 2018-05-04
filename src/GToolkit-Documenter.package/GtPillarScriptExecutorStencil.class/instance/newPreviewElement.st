instance creation
newPreviewElement
	<return: #BlElement>
	"Return a preview element that is displayed in a document"
	^ BlElement new
		layout: BlLinearLayout horizontal alignCenter;
		constraintsDo: [ :c |
			c horizontal fitContent.
			c vertical fitContent ];
		addChild: (BlTextElement new text: (' (outs at: ', workspace index asString, ') ') asRopedText);
		addChild: self newPlayButton