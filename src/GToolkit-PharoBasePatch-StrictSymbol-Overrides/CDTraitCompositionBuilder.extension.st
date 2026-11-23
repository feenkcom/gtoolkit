Extension { #name : #CDTraitCompositionBuilder }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
CDTraitCompositionBuilder >> visitArrayNode: anArrayNode [
	"Symbol>>#keywords answers Strings: compare the keyword as a String"
	<gtPharoPatch: #StrictComparison>
	| parent argumentName |
	self flag: #todo.
	"It needs to be refactored. I do not know how it was supposed to be handle properly.
	Here is workaround to fix issue with empty #uses section"
	parent := anArrayNode parent.
	parent isMessage ifTrue: [
		argumentName := (parent keywords at: (parent arguments indexOf: anArrayNode)) asString.
		(argumentName = 'uses:') | (argumentName = 'traits:') ifTrue: [
			anArrayNode statements
				ifEmpty: [
					^CDTraitCompositionSequenceNode new
						sequence: #();
						originalNode: anArrayNode;
						yourself]
				ifNotEmpty: [ :stm | ^ CDTraitCompositionSequenceNode new
											sequence: {stm first acceptVisitor: self} ;
											originalNode: anArrayNode;
											yourself
									]]].

	^anArrayNode statements collect: [ :each |
		each isLiteralNode
			ifTrue: [ each value ]
			ifFalse: [ each receiver value -> each arguments first value ] ]
]
