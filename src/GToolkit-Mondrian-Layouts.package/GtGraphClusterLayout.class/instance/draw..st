drawing-general
draw: aNode

	(self childrenFor: aNode) do: [ :e | self draw: e ].
	translator translateTopLeftOf: aNode to: (Point r: maxLayer - (self layerOf: aNode) * verticalGap theta: (maxAbcissa - (self xOf: aNode) / maxAbcissa) * 2 * Float pi )