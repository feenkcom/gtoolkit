Extension { #name : #RBRenameInstanceVariableChange }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
RBRenameInstanceVariableChange >> addNewVariable [
	"Instance variable names are Symbols; the change holds the names given (Strings)"
	<gtPharoPatch: #StrictComparison>

	(self changeClass allInstVarNames includes: (newName isString ifTrue: [ newName asSymbol ] ifFalse: [ newName ]))
		ifFalse: [ (changeFactory addInstanceVariable: newName to: self changeClass) execute ]
]

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
RBRenameInstanceVariableChange >> removeOldVariable [
	"Instance variable names are Symbols; the change holds the names given (Strings)"
	<gtPharoPatch: #StrictComparison>

	(self changeClass allInstVarNames includes: (oldName isString ifTrue: [ oldName asSymbol ] ifFalse: [ oldName ])) ifTrue: [
		(changeFactory
			 removeInstanceVariable: oldName
			 from: self changeClass) execute ]
]
