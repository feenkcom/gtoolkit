Extension { #name : #OrderedDictionary }

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
OrderedDictionary >> flatCollect: aBlock [
	<gtPharoPatch: #Pharo>
	"Evaluate aBlock for each of the receiver's values (by opposition to keys) and answer the
	list of all resulting values flatten one level. Assumes that aBlock returns some kind
	of collection for each element. Equivalent to the lisp's mapcan"
	"If you want to have keys use associations collect: or associations flatCollect: "

	^ self flatCollect: aBlock as: OrderedCollection
]
