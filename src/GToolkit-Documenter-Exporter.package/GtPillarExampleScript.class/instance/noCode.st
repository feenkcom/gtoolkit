accessing
noCode
	^ self parameters 
		at: 'noCode' 
		ifPresent: [ :value | value = 'true' or: [ value = true ] ] 
		ifAbsent: [ false ]