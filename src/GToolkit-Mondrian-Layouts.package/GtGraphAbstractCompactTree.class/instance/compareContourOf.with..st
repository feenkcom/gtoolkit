algorithm
compareContourOf: aNode with: another
	"return the number of radians the subtree induced by aNode must be displaced to be separated by a predefined distance (horizontalGap) from the one induced by anotherNode"

	| difference max nodeA nodeB |
	nodeB := aNode.	"the right one"
	nodeA := another.	"the left one"
	max := aNode = another
		ifTrue: [ 0 ]
		ifFalse: [ horizontalGap / 2 - (nodeB x - (self getAbcissaOf: nodeA inSubtreeFromLayer: aNode layer - 1)) ].
	nodeB := self followLeftContour: nodeB toLayer: nodeB layer + 1.
	nodeA := self followRightContour: nodeA toLayer: nodeA layer + 1.
	[ nodeB isNil not & nodeA isNil not ]
		whileTrue: [ 
			difference := horizontalGap
				-
					((self getAbcissaOf: nodeB inSubtreeFromLayer: aNode layer - 1)
						- (self getAbcissaOf: nodeA inSubtreeFromLayer: aNode layer - 1)).
			max := max max: difference.
			nodeB := self followLeftContour: nodeB toLayer: nodeB layer + 1.
			nodeA := self followRightContour: nodeA toLayer: nodeA layer + 1 ].
	^ max