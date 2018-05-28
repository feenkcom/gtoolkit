printing
asPillarParametersOn: aStream
	self parameters
		at: 'ref'
		ifPresent: [ :v | self asPillarKey: 'ref' value: v on: aStream ]