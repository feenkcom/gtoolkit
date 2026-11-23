Extension { #name : #OCMethodNode }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
OCMethodNode >> defines: aName [
	"Variable names are Symbols (OCVariableNode>>#name:); callers pass Strings"
	<gtPharoPatch: #StrictComparison>
	^ (arguments anySatisfy: [ :each | each name = (aName isString ifTrue: [ aName asSymbol ] ifFalse: [ aName ]) ])
		or: [ self pragmas anySatisfy: [ :pragma | pragma defines: aName ] ]
]
