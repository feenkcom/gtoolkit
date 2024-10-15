Extension { #name : #Collection }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol' }
Collection >> sameContentAs: aCollection [ 
	"Answer true if the reciever contains the same elements as aCollection, and vice versa, comparing strings and symbols based on their content."

	^(aCollection isCollection) 
		and: [ aCollection size = self size 
			and: [ aCollection allSatisfy: [ :each | 
				(aCollection occurrencesOf: each) sameContentAs: (self occurrencesOf: each) ]]]
]
