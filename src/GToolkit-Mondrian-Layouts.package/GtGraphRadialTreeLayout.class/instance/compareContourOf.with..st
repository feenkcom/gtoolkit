algorithm
compareContourOf: aNode with: another
	"return the number of radians the subtree induced by aNode must be displaced to be separated by a predefined distance (horizontalGap) from the one induced by anotherNode"

	| difference max nodeA nodeB |
	nodeB := aNode.	"the right one"
	nodeA := another.	"the left one"
	max := aNode = another
		ifTrue: [ 0 ]
		ifFalse: [ horizontalGap / (self layerOf: nodeB) / 2 - ((self xOf: nodeB) - (self getAbcissaOf: nodeA inSubtreeFromLayer: (self layerOf: aNode) - 1)) ].
	nodeB := self followLeftContour: nodeB toLayer: (self layerOf: nodeB) + 1.
	nodeA := self followRightContour: nodeA toLayer: (self layerOf: nodeA) + 1.
	[ nodeB isNil not & nodeA isNil not ]
		whileTrue: [ 
			difference := horizontalGap / (self layerOf: nodeA)
				-
					((self getAbcissaOf: nodeB inSubtreeFromLayer: (self layerOf: aNode) - 1)
						- (self getAbcissaOf: nodeA inSubtreeFromLayer: (self layerOf: aNode) - 1)).
			max := max max: difference.
			nodeB := self followLeftContour: nodeB toLayer: (self layerOf: nodeB) + 1.
			nodeA := self followRightContour: nodeA toLayer: (self layerOf: nodeA) + 1 ].
	^ max