Extension { #name : #AsyncObservableValue }

{ #category : #'*GToolkit-Extensions' }
AsyncObservableValue >> gtCompositionChildren [

	^ stream
		  ifNotNil: [ :aStream | 
			  aStream == self
				  ifFalse: [ { aStream } ]
				  ifTrue: [ #(  ) ] ]
		  ifNil: [ #(  ) ]
]
