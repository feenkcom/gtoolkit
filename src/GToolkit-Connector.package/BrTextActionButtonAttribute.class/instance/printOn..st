as yet unclassified
printOn: stream
	super printOn: stream.
	stream space.
	self source printOn: stream.
	stream nextPutAll: '->'.
	self target printOn: stream