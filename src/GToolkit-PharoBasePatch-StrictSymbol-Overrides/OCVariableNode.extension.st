Extension { #name : #OCVariableNode }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
OCVariableNode >> references: aVariableName [
	"Variable names are Symbols (OCVariableNode>>#name:); callers pass Strings"
	<gtPharoPatch: #StrictComparison>
	^self name = (aVariableName isString ifTrue: [ aVariableName asSymbol ] ifFalse: [ aVariableName ])
]

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
OCVariableNode class >> identifierNamed: anIdentifierName at: aPosition [
	"The scanner answers identifiers as Strings (buffer contents); the pseudo-variable checks compare with Symbols.
	Variable names become Symbols anyway (OCVariableNode>>#name: uses asSymbol), so convert once here."
	<gtPharoPatch: #StrictComparison>
	| aName |
	aName := anIdentifierName asSymbol.
	aName == #self
		ifTrue: [ ^ self selfNode start: aPosition ].
	aName == #thisContext
		ifTrue: [ ^ self thisContextNode start: aPosition ].
	aName == #thisProcess
		ifTrue: [ ^ self thisProcessNode start: aPosition ].
	aName == #super
		ifTrue: [ ^ self superNode start: aPosition ].
	^ self named: aName start: aPosition
]
