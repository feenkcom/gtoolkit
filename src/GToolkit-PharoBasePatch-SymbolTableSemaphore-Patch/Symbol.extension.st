Extension { #name : #Symbol }

{ #category : #'*GToolkit-PharoBasePatch-SymbolTableSemaphore-Patch' }
Symbol class >> intern: aStringOrSymbol [
	<gtPharoPatch: #Pharo12>

	SymbolTableSemaphore enabled ifFalse: [
		^ self rawIntern: aStringOrSymbol ].
	SymbolTableSemaphore singleInstance critical: [
		^ self rawIntern: aStringOrSymbol ]
]
