Extension { #name : #IceRepositoryProperties }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
IceRepositoryProperties >> writerClass [
	"The properties are keyed by Symbols (see #fileFormatId:): a String key misses them and FileTree repositories get the Tonel writer"
	<gtPharoPatch: #StrictComparison>
	^ self properties
		at: #format 
		ifPresent: [ :v | TIceRepositoryWriter users detect: [ :each | each id = v  ] ]
		ifAbsent: [ 
			commitish project isInvalid
				ifFalse: [ IceLibgitRepository defaultFileFormat ]
				ifTrue: [ TIceRepositoryWriter users
					detect: #isLegacyDefault
					ifNone: [ Smalltalk at: #IceLibgitFiletreeWriter ] ]  ]

]
