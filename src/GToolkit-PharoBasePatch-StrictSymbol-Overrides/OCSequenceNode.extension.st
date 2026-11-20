Extension { #name : #OCSequenceNode }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
OCSequenceNode >> defines: aName [
	"Variable names are Symbols (OCVariableNode>>#name:); callers pass Strings"
	<gtPharoPatch: #StrictComparison>
	^temporaries anySatisfy: [:each | each name = (aName isString ifTrue: [ aName asSymbol ] ifFalse: [ aName ])]
]

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
OCSequenceNode >> removeTemporaryNamed: aName [
	"Variable names are Symbols (OCVariableNode>>#name:); callers pass Strings"
	<gtPharoPatch: #StrictComparison>
	temporaries := temporaries reject: [:each | each name = (aName isString ifTrue: [ aName asSymbol ] ifFalse: [ aName ])]
]
