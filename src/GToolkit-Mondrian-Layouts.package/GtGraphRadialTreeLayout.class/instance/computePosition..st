algorithm
computePosition: aNode
"compute the position of the given node and of his sons recursively"

	| children neighbor nodeA |
	
	children :=self childrenFor: aNode.
	neighbor := self leftSiblingOf: aNode.
	
	children isEmpty ifTrue: [ neighbor isNil ifTrue: [ self xOf: aNode put: 0. self modOf: aNode put: 0. ]  
		
											 ifFalse: [ self xOf: aNode put: ((self xOf: neighbor) + (horizontalGap /(self layerOf: aNode) /2)). self modOf: aNode put: ((self modOf: neighbor)).
													 self pointerOf: aNode put: (self followRightContour: neighbor toLayer: ((self layerOf: aNode) + 1)) ] ]
					 
					 ifFalse: [ self leftContourOf: aNode put: children first.
									self rightContourOf: aNode put: children last.
							  children do: [:e | self computePosition: e ].
							      self xOf: aNode put: ((self xOf: ( self leftContourOf: aNode ) ) + ( self xOf: ( self rightContourOf: aNode ) ) + (self modOf: ( self rightContourOf: aNode ) ) ) / 2. 
										self modOf: aNode put: 0. 
								neighbor isNil ifFalse: [ self modOf: aNode put: (self compareContourOf: aNode with: neighbor).
									
													  nodeA := (self followLeftContour: (self fatherOf: aNode) toLayer: (self layerOf: aNode)).
													  [(self followLeftContour: nodeA toLayer: ((self layerOf: nodeA) + 1)) isNil ] whileFalse: [ nodeA := self followLeftContour: nodeA toLayer: ((self layerOf: nodeA) + 1) ].
													 self pointerOf: nodeA put: (self followLeftContour: aNode toLayer: ((self layerOf: nodeA) + 1)).
													
													 nodeA := self followRightContour: aNode toLayer: ((self layerOf: aNode) + 1).
													 [(self followRightContour: nodeA toLayer: ((self layerOf: nodeA) + 1)) isNil ] whileFalse: [ nodeA := self followRightContour: nodeA toLayer: ((self layerOf: nodeA) +1) ].
													self pointerOf: nodeA put: (self followRightContour: neighbor toLayer: ((self layerOf: nodeA) + 1) ) ] ]. 
											