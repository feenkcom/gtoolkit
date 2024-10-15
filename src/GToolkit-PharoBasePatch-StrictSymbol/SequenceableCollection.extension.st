Extension { #name : #SequenceableCollection }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol' }
SequenceableCollection >> hasSameContentElements: otherCollection [
	"Answer whether the receiver's size is the same as otherCollection's
	size, and each of the receiver's elements equal the corresponding
	element of otherCollection.
	Compare strings and symbols based on their content ."
	| size |

	(otherCollection isKindOf: SequenceableCollection) ifFalse: [ ^ false ].
	(size := self size) = otherCollection size ifFalse: [ ^ false ].
	1 to: size do: [ :index | 
		((self at: index) sameContentAs: (otherCollection at: index))
			ifFalse: [ ^ false ] ].
	^ true
]

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol' }
SequenceableCollection >> sameContentAs: otherCollection [
	"Answer true if the receiver is equivalent to the otherCollection.
	First test for identity, then rule out different species and sizes of
	collections. As a last resort, examine each element of the receiver
	and the otherCollection.
	Compare strings and symbols based on their content."

	self == otherCollection ifTrue: [^ true].
	self species == otherCollection species ifFalse: [^ false].
	^ self hasSameContentElements: otherCollection
]
