Extension { #name : #TonelWriter }

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
TonelWriter >> setPackageInfoOf: aClassDefinition in: definition [
	<gtPharoPatch: #Pharo>
	
	self at: #category put: aClassDefinition category asSymbol in: definition
]
