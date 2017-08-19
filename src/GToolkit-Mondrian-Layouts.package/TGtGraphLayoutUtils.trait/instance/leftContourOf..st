utils
leftContourOf: aNode
	^ aNode userData at: #leftContour ifAbsent: [ ^ nil ]