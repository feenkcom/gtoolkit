Extension { #name : #Behavior }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
Behavior >> ffiInstVarArgument: argName generator: generator [
	"Load the instance variable with given name (instance variable names are Symbols)"
	<gtPharoPatch: #StrictComparison>

	(self allInstVarNames includes: argName asSymbol) ifFalse: [ ^ nil ].
	^ FFIInstVarArgument new
		argName: argName;
		yourself
]

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
Behavior >> whichClassDefinesInstVar: aString [
	"Instance variable names are Symbols; callers pass Strings (RBVariableEnvironment class>>#on:referencesToInstanceVariable:in:). whichClassDefinesClassVar: already looks up the Symbol."
	<reflection: 'Class structural inspection - Instance variable inspection'>
	<gtPharoPatch: #StrictComparison>
	| aName |
	aName := aString isString ifTrue: [ aString asSymbol ] ifFalse: [ aString ].
	^self
		whichSuperclassSatisfies: [:aClass | aClass instVarNames includes: aName]
]
