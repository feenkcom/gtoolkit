initialize-release
initializeNode: aNode

	|children|
	
	children := self childrenFor: aNode.
	
	children do: [ :e | self initializeNode: e.
						self fatherOf: e put: aNode ].

	children isEmpty ifTrue: [ self layerOf: aNode put: 0.
							externalLayer add: aNode ] 
					ifFalse: [ self layerOf: aNode put: ((children collect: [ :e | (self layerOf: e) ]) max + 1).
							self leftContourOf: aNode put: children first.
							self rightContourOf: aNode put: children last ].
					