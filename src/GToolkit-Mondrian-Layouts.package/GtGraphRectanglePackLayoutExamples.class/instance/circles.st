example
circles
	<gtExample>
	<script: 'self new circles asSpartaForm asMorph openInWindow'>
	| view nodes data |

	data := self circlesData.

	view := self view.
	nodes := self nodes: data.
	nodes do: [ :node || model label |
		model := node userData at: #model.
		node
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
		node layout: BlFrameLayout new ].
	
	view addChildren: nodes.
	view layout: (GtGraphRectanglePackLayout new gap: 0).
	self applyLayoutIn: view.

	^ view