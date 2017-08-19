private
shiftTree: aNode by: aPoint
	
	aNode position: aNode position + aPoint.
	(self childrenFor: aNode) do: [:child | self shiftTree: child by: aPoint]