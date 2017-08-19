private
maximumDiameter: aCollection
	
	^aCollection
		inject: 0
		into: [:max :node | max max: (node constraints graph radius * 2) ]
 