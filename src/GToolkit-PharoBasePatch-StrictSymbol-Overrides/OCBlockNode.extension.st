Extension { #name : #OCBlockNode }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
OCBlockNode >> defines: aName [
	"Variable names are Symbols (OCVariableNode>>#name:); callers pass Strings"
	<gtPharoPatch: #StrictComparison>
	^arguments anySatisfy: [:each | each name = (aName isString ifTrue: [ aName asSymbol ] ifFalse: [ aName ])]
]
