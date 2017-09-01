accessing-defaults
defaultProviderFor: aCompiledMethod 
	^ aCompiledMethod methodClass isMeta
		ifTrue: [ aCompiledMethod methodClass theNonMetaClass ]
		ifFalse: [ aCompiledMethod methodClass theNonMetaClass new " WARNING: not all classes support this -> override this using: #provider: " ] 