examples
passiveEdgesWithNesting
	<gtExample>
	| view |
	view := GtMondrian new.
	view nodes
		shape: [ :x | 
			BlElement new 
				geometry: BlEllipse new; 
				border: (BlBorder paint: Color black);
				constraintsDo: [ :c | c padding: (BlInsets all: 10) ] ];
		with: (1 to: 9)
		forEach: [ :each |
			view nodes 
				shape: [ :x | BlTextElement new text: x asString asRopedText ];
				with: (10 * each to: (10 * each + 9)).
			view layout circle radius: 50 ].
	view edges 
		fromCenterBottom;
		toCenterTop;
		connectFrom: [ :x | x // 2 ].
	view edges 
		shape: [ :x |
			BlLineElement new
				border: (BlBorder paint: (Color red alpha: 0.5) width: 5) ];
		passive; 
		connect: { 1->53 . 11 -> 19 } from: #key to: #value.
	view layout tree.
	^ view