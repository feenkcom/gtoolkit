Extension { #name : #ReCheckVariableNameCondition }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
ReCheckVariableNameCondition >> check [
	"Variable names are Symbols; the condition gets a String"
	<gtPharoPatch: #StrictComparison>

	(class whoDefinesInstanceVariable: variableName) ifNotNil: [ 
		violators add: ('<1p> defines an instance variable named <2s>'
			expandMacrosWith: class
         with: variableName )].
	(class whoDefinesClassVariable: variableName ) ifNotNil: [
   		violators add: ('<1p> defines a class variable named <2s>'
      		expandMacrosWith: class
         with: variableName)].
	(parseTree whoDefines: variableName)
		ifNotNil: [ 
			violators add: ('<1s> is already defined' expandMacrosWith: variableName) ].
	(parseTree allDefinedVariables includes: (variableName isString ifTrue: [ variableName asSymbol ] ifFalse: [ variableName ]) ) ifTrue: [
		violators add: ('<1s> is already a temporary variable name'
      		expandMacrosWith: variableName )].
	^ violators isEmpty
]
