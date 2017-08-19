utils
fatherOf: aNode
	^ aNode userData at: #father ifAbsent: [ nil ]