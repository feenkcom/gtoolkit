Extension { #name : #SequenceableCollection }

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
