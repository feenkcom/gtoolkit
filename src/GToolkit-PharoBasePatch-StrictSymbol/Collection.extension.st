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
Collection >> includesSameContentAs: anObject [
	"Answer whether one of my elements has the same content as anObject: a String and a Symbol with the same characters match (see #sameContentAs:), other objects match by #=.
	Use me where a collection may hold names of both kinds (for example Iceberg package names); where all elements are Symbols and a Symbol is at hand, #includes: is enough."

	^ self anySatisfy: [ :each | each sameContentAs: anObject ]
]

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol' }
Collection >> sameContentAs: aCollection [
	"Answer true if the receiver contains the same elements as aCollection, and vice versa, comparing strings and symbols based on their content.
	The elements of the receiver are counted in a GtStringContentDictionary (#occurrencesOf: compares with #=), then counted down with the elements of aCollection."

	| counts |
	aCollection isCollection ifFalse: [ ^ false ].
	aCollection size = self size ifFalse: [ ^ false ].
	counts := GtStringContentDictionary new.
	self do: [ :each | counts at: each put: (counts at: each ifAbsent: [ 0 ]) + 1 ].
	^ aCollection
		allSatisfy: [ :each | 
			| aCount |
			aCount := counts at: each ifAbsent: [ 0 ].
			aCount > 0 and: [ counts at: each put: aCount - 1.
					true ] ]
]

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol' }
Collection >> stringContentIntersection: aCollection [
	"Answer the set theoretic intersection of two collections.
	Compare Strings and Symbols based on their content."

	"(#(1 2 3 4) intersection: #(3 4 5)) >>> #(3 4)"

	"(#(1 2 3 4) intersection: #()) >>> #()"

	"(#() intersection: #(1 2 3 4)) >>> #()"

	"('hello' intersection: 'world') >>> 'ol'"

	^ self species withAll: (self asGtStringContentSet intersection: aCollection) asArray
]
