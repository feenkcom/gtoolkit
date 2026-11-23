Extension { #name : #Class }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
Class >> hasClassVarNamed: aString [
	"The class pool is keyed by Symbols; callers pass Strings"
	<gtPharoPatch: #StrictComparison>
	"Return whether the receiver has a class variables (shared variables among its class and subclasses) named: aString"
	<reflection: 'Class structural inspection - Class variable inspection'>
	^ self classPool includesKey: (aString isString ifTrue: [ aString asSymbol ] ifFalse: [ aString ])
]

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
Class >> usesClassVarNamed: aString [
	"Class variable names are Symbols; callers (usesPoolVarNamed:, sharedPoolOfVarNamed:) pass Strings"
	<gtPharoPatch: #StrictComparison>
	"Return whether the receiver or its superclasses have a class variable named: aString"
	<reflection: 'Class structural inspection - Class variable inspection'>
	^ self allClassVarNames includes: (aString isString ifTrue: [ aString asSymbol ] ifFalse: [ aString ])
]
