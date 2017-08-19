algorithm
computePosition: aNode
	| children previous |
	children := self childrenFor: aNode.
	children do: [ :e | self computePosition: e ].
	children isEmpty
		ifTrue: [ externalLayer first = aNode
				ifFalse: [ previous := externalLayer at: (externalLayer indexOf: aNode) - 1.
					(self fatherOf: previous) = (self fatherOf: aNode)
						ifTrue: [ self xOf: aNode put: (self xOf: previous) + (horizontalGap / 2) ]
						ifFalse: [ self xOf: aNode put: (self xOf: previous) + horizontalGap ] ] ]
		ifFalse: [ self xOf: aNode put: ((self xOf: (self leftContourOf: aNode)) + (self xOf: (self rightContourOf: aNode))) / 2 ]