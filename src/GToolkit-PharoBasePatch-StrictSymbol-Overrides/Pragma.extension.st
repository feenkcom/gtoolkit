Extension { #name : #Pragma }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
Pragma >> argumentNamed: aSymbol ifNone: aBlockClosure [
	"Answer the argument of the pragma after the keyword given as parameter.
	If none, return the result of the block given as parameter.

	I am more readable than #argumentAt: but also slower."
	"Symbol>>#keywords answers Strings"
	<gtPharoPatch: #StrictComparison>

	^ self argumentAt:
		(self selector keywords
			indexOf: aSymbol asMutator asString
			ifAbsent: [ ^ aBlockClosure value])
]
