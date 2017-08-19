utils
pointerOf: aNode

	^ aNode userData at: #pointer ifAbsent: [ ^ nil ]