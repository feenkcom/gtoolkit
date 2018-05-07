accessing
tokens: aCollection 
	tokens := aCollection.
	parameters := aCollection second asDictionary keysAndValuesRemove: [ :key :value | key isEmpty and: [ value isNil ] ].