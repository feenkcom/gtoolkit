example
circlesRaw
	<gtExample>
	<script: 'self new circlesRaw asSpartaForm asMorph openInWindow'>
	| view data |

	data := self circlesData.

	view := BlElement new.
	data do: [ :model || node label |
		node := BlElement new 
			geometry: BlEllipse new;
			size: model value asPoint;
			background: Color random.
		label := BlTextElement new.
		label text: ((BrRopedText string: model key)
			attributes: {  
				BrTextForegroundAttribute paint: Color black .
				BrFontSizeAttribute size: 10 } ).
		label constraintsDo: [ :constraints |
			constraints frame horizontal alignCenter.
			constraints frame vertical alignCenter ].
		node addChild: label.
		node layout: BlFrameLayout new.
		
		view addChild: node ].
	
	view layout: (GtGraphRectanglePackLayout new gap: 0).
	view constraintsDo: [ :constraints |
		constraints horizontal fitContent.
		constraints vertical fitContent.
		constraints padding: (BlInsets all: 10) ].

	self applyLayoutIn: view.

	^ view