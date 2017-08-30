example
example
	<gtExample>
	| label contents contentLabel grid |
	label := BlTextElement new
            text: (BrRopedText string: 'Name');
            background: (BlBackground paint: Color white);
            yourself.
	contents := BlElement new.
	contents 
	    layout: BlLinearLayout horizontal;
	   constraintsDo: [ :c |
	        c vertical exact: 100.
	        c horizontal fitContent ];
	    background: Color white.
	contentLabel := BlTextElement new
	            text: (BrRopedText string: 'Label with multiple words');
	            background: (BlBackground paint: Color white);
	            yourself.
	contents addChild: contentLabel.
	grid := GtWidthExpandingElement new.
	grid 
	    layout: (BlGridLayout vertical cellSpacing: 2);
	    constraintsDo: [ :c |
	        c vertical fitContent.
	        c horizontal fitContent ];
	    background: Color black.
	grid addChildren: { label . contents }.
	^ grid