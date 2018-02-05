accessing
show
	^ self parameters 
		at: 'show' 
		ifPresent: [ :value | value asSymbol ]
		ifAbsent: [ nil ]