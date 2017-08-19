algorithm
radialDraw: aNode
	"draw the subtree induced by the given node"

	| children r max |
	r := (self rOf: aNode).
	translator translateTopLeftOf: aNode to: (Point r: r theta: (self thetaOf: aNode)).
	"aNode translateTo: (Point radius: (aNode r) theta: (aNode theta))."
	children := self childrenFor: aNode.
	max := 0.
	children do: [ :e | max := max max: (self radialDraw: e) ].
	^ r + max.