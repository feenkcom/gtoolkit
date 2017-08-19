private
centeredString: aString in: aNode
	| label |
	label := BlTextElement new.
	label text: (BrRopedText string: aString).
	label constraintsDo: [ :constraints |
		constraints frame horizontal alignCenter.
		constraints frame vertical alignCenter.
		constraints padding: (BlInsets all: 1) ].
	aNode addChild: label.
	aNode layout: BlFrameLayout new.
	^ label