accessing
example
	^ self parameters at: 'example' ifAbsent: [ nil ]