accessing
height
	^ self parameters 
		at: 'height'
		ifPresent: [ :aString | Number readFromString: aString ] 
		ifAbsent: [ nil ]