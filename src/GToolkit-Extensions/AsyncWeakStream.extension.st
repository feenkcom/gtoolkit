Extension { #name : #AsyncWeakStream }

{ #category : #'*GToolkit-Extensions' }
AsyncWeakStream >> gtCompositionChildren [

	^ stream first
		ifNil: [ #() ]
		ifNotNil: [ :aStream | { aStream } ]
]
