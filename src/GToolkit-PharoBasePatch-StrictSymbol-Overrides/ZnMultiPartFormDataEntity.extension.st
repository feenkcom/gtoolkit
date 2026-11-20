Extension { #name : #ZnMultiPartFormDataEntity }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
ZnMultiPartFormDataEntity >> partNamed: fieldName ifNone: block [
	"Field names are Strings; callers pass Symbols"
	<gtPharoPatch: #StrictComparison>

	parts ifNil: block.
	^ self parts detect: [ :each | ((each fieldName isString and: [ fieldName isString ]) ifTrue: [ each fieldName asString = fieldName asString ] ifFalse: [ each fieldName = fieldName ]) ] ifNone: block
]
