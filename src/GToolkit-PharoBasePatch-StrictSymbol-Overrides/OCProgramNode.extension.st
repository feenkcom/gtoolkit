Extension { #name : #OCProgramNode }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
OCProgramNode >> equalTo: aNode exceptForVariables: variableNameCollection [
	"Variable names are Symbols; callers pass the names to ignore as Strings"
	<gtPharoPatch: #StrictComparison>
	| dictionary |
	dictionary := Dictionary new.
	(self equalTo: aNode withMapping: dictionary) ifFalse: [^false].
	dictionary keysAndValuesDo:
			[:key :value |
			(key = value or: [variableNameCollection anySatisfy: [ :each | (each isString and: [ key isString ]) ifTrue: [ each asString = key asString ] ifFalse: [ each = key ] ] ]) ifFalse: [^false]].
	^true
]
