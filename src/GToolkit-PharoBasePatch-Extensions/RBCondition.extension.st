Extension { #name : #RBCondition }

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
RBCondition class >> true [
	<gtPharoPatch: #Pharo12>
	"Returns a true condition. It is useful when chaining condition. It acts as neutral element of the operation such AND."

	^ self 
		forPharo12: [	
			self new
				block: [true]
				errorString: 'true'] 
		forPharo11AndPharo10: [
			self empty  ]
]
