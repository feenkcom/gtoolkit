example
simple
	<gtExample>
	<script: 'self new simple asSpartaForm asMorph openInWindow'>
	| view nodes |

	view := self view.
	nodes := self nodes: (1 to: 50).
	nodes do: [ :node | node size: (100 atRandom @ 100 atRandom) ].
	
	view addChildren: nodes.
	view layout: GtGraphRectanglePackLayout new.

	self applyLayoutIn: view.

	^ view