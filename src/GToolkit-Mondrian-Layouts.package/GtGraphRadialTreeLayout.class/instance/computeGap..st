hook
computeGap: aNode
	" compute the vertical gap needed for drawing the radial tree "
	| gap maxAbcissa i abc nodeL nodeR layer |	
	gap := 0.
	maxAbcissa := 0.
	layer := 1.
	
	i := 1.
	[ nodeL :=(self followLeftContour: aNode toLayer: i).
	nodeR := (self followRightContour: aNode toLayer: i).
	nodeL isNil not & nodeR isNil not ] whileTrue: [ abc := (((self getAbcissaOf: nodeR inSubtreeFromLayer: 0) - (self getAbcissaOf: nodeL inSubtreeFromLayer: 0 ) + (horizontalGap / layer/2)) / layer).
																	(abc > maxAbcissa) ifTrue: [ maxAbcissa := abc. 
																								layer := layer ].
																	i := i + 1 ].

	
	gap:= (maxAbcissa / 2 /Float pi ) floor +1.
	
	((verticalGap isNil) or: [gap > verticalGap])  ifTrue: [ self verticalGap: gap ]