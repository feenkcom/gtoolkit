Trait {
	#name : #TGtInteractiveStatusInstantiation,
	#category : #'GToolkit-World-Notifications'
}

{ #category : #'instance creation' }
TGtInteractiveStatusInstantiation classSide >> statusFor: aRegistryValue ifNone: aBlock [
	^ self subclasses 
		detect: [ :aSubclass | aSubclass registryValue = aRegistryValue ]
		ifFound: [ :aSubclass | aSubclass new ] 
		ifNone: aBlock
		
]
