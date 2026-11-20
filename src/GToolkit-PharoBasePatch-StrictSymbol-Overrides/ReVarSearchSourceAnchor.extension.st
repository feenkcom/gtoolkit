Extension { #name : #ReVarSearchSourceAnchor }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
ReVarSearchSourceAnchor >> modify: aString for: aStringCollection [
	"Variable names are Symbols, the search string a String"
	<gtPharoPatch: #StrictComparison>

	aStringCollection size = 1 ifTrue: [
		^ aString surroundedBySingleQuotes ].
	aStringCollection first asString = aString asString ifTrue: [
		^ '''', aString, String space ].
	aStringCollection last asString = aString asString ifTrue: [
		^ String space, aString, '''' ].
	^ aString surroundedBy: String space
]

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
ReVarSearchSourceAnchor >> searchString [
	"Variable names are Symbols, the search string a String"
	<gtPharoPatch: #StrictComparison>
	| origString |

	origString := super searchString.
	(sourceEntity instVarNames includes: (origString isString ifTrue: [ origString asSymbol ] ifFalse: [ origString ])) ifTrue: [
		^ self modify: origString for: sourceEntity instVarNames ].
	(sourceEntity classVarNames includes: (origString isString ifTrue: [ origString asSymbol ] ifFalse: [ origString ])) ifTrue: [
		^ self modify: origString for: sourceEntity classVarNames ].

	^ origString
]
