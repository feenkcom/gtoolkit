utils
rightContourOf: aNode
	^ aNode userData at: #rightContour ifAbsent: [ ^ nil ]