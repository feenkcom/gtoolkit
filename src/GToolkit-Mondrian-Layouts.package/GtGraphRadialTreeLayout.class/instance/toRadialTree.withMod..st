algorithm
toRadialTree: aNode withMod: aFloat
	"compute polar coordinates of the subtree induced by anode from its cartesian coordinates "
	| children |
	self rOf: aNode put: ((self layerOf: aNode) * verticalGap ).
	((self rOf: aNode) = 0) ifTrue: [ self thetaOf: aNode put: 0 ] 
					ifFalse: [ self thetaOf: aNode put: ((self xOf: aNode)  + aFloat + (self modOf: aNode)) / verticalGap ].
	
	children := self childrenFor: aNode.
	
	children do: [ :e | self toRadialTree: e withMod: ( (self modOf: aNode) + aFloat) ]