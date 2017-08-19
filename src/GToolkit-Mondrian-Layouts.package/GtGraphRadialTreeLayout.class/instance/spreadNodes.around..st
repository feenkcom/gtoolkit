hook
spreadNodes: nodeElements around: aNode

	|nodeL nodeR i angle beta lay1 |
	
	i := 1.
	angle := 0.
	
	[ nodeL :=(self followLeftContour: aNode toLayer: i).
	nodeR := (self followRightContour: aNode toLayer: i).
	nodeL isNil not & nodeR isNil not ] whileTrue: [ angle := angle max: ((nodeR theta - nodeL theta) + ((self halfDiameterOf: nodeR) + (self halfDiameterOf: nodeL) + horizontalGap  /i /verticalGap )).
													i := i+1. ].

	lay1 := nodeElements select: [ :e | e layer = 1 ].

	beta := Float pi * 2 - angle / lay1 size.
	
	lay1 do: [ :e | self rotateSubtreeFrom: e by: (lay1 indexOf: e) - 1 * beta ].