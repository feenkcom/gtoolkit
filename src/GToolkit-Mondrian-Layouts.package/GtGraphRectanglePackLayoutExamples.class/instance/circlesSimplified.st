example
circlesSimplified
	<gtExample>
	<script: 'self new circles asSpartaForm asMorph openInWindow'>
	| view data |

	data := self circlesData.

	view := self view.
	self nodes: data inView: view forEach: [ :node |
		| model label |
		model := self modelFor: node.
		node
			geometry: BlEllipse new;
			size: model value asPoint;
			background: Color random.
		label := self centeredString: model key in: node.
		label text attributes: { 
			BrTextForegroundAttribute paint: Color black .
			BrFontSizeAttribute size: 10 } ].
	
	view layout: (GtGraphRectanglePackLayout new gap: 0).
	self applyLayoutIn: view.

	^ view