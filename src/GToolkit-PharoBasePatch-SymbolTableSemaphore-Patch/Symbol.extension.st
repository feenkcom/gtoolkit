Extension { #name : #Symbol }

{ #category : #'*GToolkit-PharoBasePatch-SymbolTableSemaphore-Patch' }
Symbol class >> intern: aStringOrSymbol [
	<gtPharoPatch: #Pharo12>
	
	LwGtSymbolTableSemaphore enabled ifFalse: [
		^ (self findInterned: aStringOrSymbol) ifNil: [
		  	NewSymbols add: aStringOrSymbol createSymbol ] ].
		  	
	LwGtSymbolTableSemaphore singleInstance critical: [
		^ (self findInterned: aStringOrSymbol) ifNil: [
		  	NewSymbols add: aStringOrSymbol createSymbol ] ]
]
