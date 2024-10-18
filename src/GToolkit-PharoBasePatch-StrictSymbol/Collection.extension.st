Extension { #name : #Collection }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol' }
Collection >> asGtStringContentSet [
	"Answer a GtStringContentSet whose elements are the unique elements of the receiver."

	"{1. 2} asSet =    {2. 1} asSet >>> true"
	"{1. 2} asSet = {1. 2. 2} asSet >>> true"
	"{1. 2} asSet = {1. 2. 3} asSet >>> false"
	"{} asSet = Set new >>> true"

	^ GtStringContentSet withAll: self
]

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol' }
Collection >> sameContentAs: aCollection [ 
	"Answer true if the reciever contains the same elements as aCollection, and vice versa, comparing strings and symbols based on their content."

	^(aCollection isCollection) 
		and: [ aCollection size = self size 
			and: [ aCollection allSatisfy: [ :each | 
				(aCollection occurrencesOf: each) sameContentAs: (self occurrencesOf: each) ]]]
]
