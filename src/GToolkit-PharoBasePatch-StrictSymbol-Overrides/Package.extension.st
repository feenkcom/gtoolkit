Extension { #name : #Package }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
Package >> hasTag: aTag [
	"Tag names are Symbols (tagNames); callers pass Strings"
	<gtPharoPatch: #StrictComparison>
	"Takes a package tag or a package tag name as parameter and return true if I include this package tag."

	^ self tagNames includes: (aTag isString
			   ifTrue: [ aTag asSymbol ]
			   ifFalse: [ aTag name ])
]

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
Package >> includesClassNamed: aSymbol [
	"Class names are Symbols; callers pass Strings"
	<gtPharoPatch: #StrictComparison>
	"Returns true if the receiver includes class named aSymbol in the classes that are defined within it: only class definition are considered - not class extensions"

	| aName |
	aName := aSymbol isString ifTrue: [ aSymbol asSymbol ] ifFalse: [ aSymbol ].
	^ self definedClasses anySatisfy: [ :class | class name = aName ]
]

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
Package >> tagNamed: aSymbol [
	"Tag names are Symbols; callers pass Strings"
	<gtPharoPatch: #StrictComparison>
	| aName |
	aName := aSymbol isString ifTrue: [ aSymbol asSymbol ] ifFalse: [ aSymbol ].
	^ self tags detect: [ :each | each name = aName ]
]

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
Package >> tagNamed: aSymbol ifAbsent: aBlock [
	"Tag names are Symbols; callers pass Strings"
	<gtPharoPatch: #StrictComparison>
	| aName |
	aName := aSymbol isString ifTrue: [ aSymbol asSymbol ] ifFalse: [ aSymbol ].
	^ self tags
		  detect: [ :each | each name = aName ]
		  ifNone: aBlock
]

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
Package >> tagNamed: aSymbol ifPresent: aBlock [
	"Tag names are Symbols; callers pass Strings"
	<gtPharoPatch: #StrictComparison>

	^ self tags
		  detect: [ :each | each name = (aSymbol isString ifTrue: [ aSymbol asSymbol ] ifFalse: [ aSymbol ]) ]
		  ifFound: [ :tag | aBlock cull: tag ]
		  ifNone: [ nil ]
]
