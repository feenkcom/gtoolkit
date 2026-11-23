Extension { #name : #OCReadBeforeWrittenTester }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
OCReadBeforeWrittenTester >> variableRead: aNode [
	"The scope is keyed by the variable names given (initializeVars:, often Strings), the nodes have Symbol names"
	<gtPharoPatch: #StrictComparison>

	| aKey |
	aKey := (self currentScope includesKey: aNode name) ifTrue: [ aNode name ] ifFalse: [ aNode name asString ].
	( self currentScope includesKey: aKey )
		ifTrue: [ ( self currentScope at: aKey ) ifNil: [ self currentScope at: aKey put: true ] ]
]

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
OCReadBeforeWrittenTester >> variableWritten: aNode [
	"The scope is keyed by the variable names given (initializeVars:, often Strings), the nodes have Symbol names"
	<gtPharoPatch: #StrictComparison>

	| aKey |
	aKey := (self currentScope includesKey: aNode variable name) ifTrue: [ aNode variable name ] ifFalse: [ aNode variable name asString ].
	( self currentScope includesKey: aKey )
		ifTrue: [ ( self currentScope at: aKey )
				ifNil: [ self currentScope at: aKey put: false ]
			]
]
