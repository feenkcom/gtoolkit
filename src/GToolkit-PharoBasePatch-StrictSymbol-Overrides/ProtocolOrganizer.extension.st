Extension { #name : #ProtocolOrganizer }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
ProtocolOrganizer >> classify: aSymbol inProtocolNamed: aProtocolName [
	| name protocol |
	name := aProtocolName.
	(name sameContentAs: allProtocol name)
		ifTrue: [ name := Protocol unclassified ].	"maybe here we should check if this method already belong to another protocol"
	(self protocolsOfSelector: aSymbol)
		do: [ :p | p removeMethodSelector: aSymbol ].
	protocol := self getProtocolNamed: name ifNone: [ self addProtocolNamed: name ].

	protocol addMethodSelector: aSymbol
]

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
ProtocolOrganizer >> getProtocolNamed: aByteString ifNone: aBlockClosure [
	^ protocols
		detect: [ :e | e name sameContentAs: aByteString ]
		ifNone: aBlockClosure
]

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
ProtocolOrganizer >> protocolNamed: aString ifAbsent: aBlock [
	^ self allProtocols
		detect: [ :e | e name sameContentAs: aString ]
		ifNone: aBlock
]
