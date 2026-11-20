Extension { #name : #ReEmptyExceptionHandlerRule }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
ReEmptyExceptionHandlerRule >> afterCheck: aNode mappings: mappingDict [
	"RePatternCodeRule>>#flattenMatchMap: keys the mappings by the pattern variable names (Symbols)"
	<gtPharoPatch: #StrictComparison>
	| exception class |
	exception := mappingDict at: #'`exception'.

	exception isVariable ifFalse: [ ^ false ].
	(class := aNode methodNode methodClass environment classNamed: exception name) ifNil: [ ^ false ].
	(class includesBehavior: Exception) ifFalse: [ ^ false ].
	(class includesBehavior: Notification) ifTrue: [ ^false ].

	^ true
]
