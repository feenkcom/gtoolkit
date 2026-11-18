Extension { #name : #Object }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol' }
Object >> isStrictString [
	"Answer whether the receiver is a String that is not a Symbol"

	^ false
]

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol' }
Object >> sameContentAs: anObject [

	^ self = anObject
]
