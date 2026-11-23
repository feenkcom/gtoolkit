Extension { #name : #ClassDescription }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
ClassDescription >> hasProtocol: aProtocol [
	"Protocol names are Symbols; callers pass Strings ('accessing')"
	<gtPharoPatch: #StrictComparison>

	^ self protocolNames includes: (aProtocol isString ifTrue: [ aProtocol asSymbol ] ifFalse: [ aProtocol name ])
]

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
ClassDescription >> isTaggedWith: aSymbol [
	"Tag names are Symbols; callers pass Strings"
	<gtPharoPatch: #StrictComparison>

	^ self packageTagName
		  ifNil: [ false ]
		  ifNotNil: [ :tag | tag = (aSymbol isString ifTrue: [ aSymbol asSymbol ] ifFalse: [ aSymbol ]) ]
]

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
ClassDescription >> protocolNamed: aString ifAbsent: aBlock [
	"Protocol names are Symbols; callers pass Strings"
	<gtPharoPatch: #StrictComparison>
	| aName |
	aName := aString isString ifTrue: [ aString asSymbol ] ifFalse: [ aString ].
	^ self protocols
		  detect: [ :e | e name = aName ]
		  ifNone: aBlock
]
