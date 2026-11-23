Extension { #name : #RBRenameClassVariableChange }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
RBRenameClassVariableChange >> copyOldValuesToNewVariable [
	"The class pool is keyed by Symbols"
	<gtPharoPatch: #StrictComparison>

	| oldValue |
	oldValue := self changeClass classPool at: (oldName isString ifTrue: [ oldName asSymbol ] ifFalse: [ oldName ]) ifAbsent: [ nil ].
	self changeClass classPool at: newName asSymbol put: oldValue
]
