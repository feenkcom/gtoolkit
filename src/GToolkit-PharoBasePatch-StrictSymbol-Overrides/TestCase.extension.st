Extension { #name : #TestCase }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
TestCase >> cleanUpInstanceVariables [
	"instanceVariablesToKeep answers Strings (#('testSelector'), also in the subclasses); instance variable names are Symbols"
	<gtPharoPatch: #StrictComparison>
	| toKeep |
	toKeep := self instanceVariablesToKeep collect: [ :each | each asSymbol ].
	self class allInstVarNames do: [ :name |
		(toKeep includes: name) ifFalse: [
			self instVarNamed: name put: nil ] ]
]
