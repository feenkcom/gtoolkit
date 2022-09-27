Extension { #name : #AsyncFanoutSink }

{ #category : #'*Gtoolkit-Extensions' }
AsyncFanoutSink >> gtCompositionChildren [
	^ {sinkA.
		sinkB}
]
