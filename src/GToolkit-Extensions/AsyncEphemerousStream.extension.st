Extension { #name : #AsyncEphemerousStream }

{ #category : #'*GToolkit-Extensions' }
AsyncEphemerousStream >> gtCompositionChildren [

	^ stream first
		ifNil: [ #() ]
		ifNotNil: [ :aStream | { aStream } ]
]
