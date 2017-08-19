execution
packIn: anElement
	translator translateTopLeftOf: anElement to: (self bestSpaceFor: anElement) origin + padding.
	bounds := bounds max: anElement boundsInParent bottomRight + padding.
	
	self recalculateFreeSpacesWith: anElement