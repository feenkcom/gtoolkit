Extension { #name : #TonelWriterV1 }

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
TonelWriterV1 >> setPackageInfoOf: aClassDefinition in: definition [
	<gtPharoPatch: #Pharo>
	
	self at: #category put: aClassDefinition category asSymbol in: definition
]
