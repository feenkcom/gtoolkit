hook
rotateSubtreeFrom: aNode by: aFloat
	
	aNode theta: aNode theta + aFloat.
	
	(self childrenFor: aNode) do: [ :e | self rotateSubtreeFrom: e by: aFloat ]