Extension { #name : #Object }

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
Object >> isPharoPackageModel [
	^ self 
		forPharo12AndNewer: [ self isKindOf: Package ] 
		forPharo11: [ self isKindOf: RPackage ]
]

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
Object >> isPharoPackageTagModel [
	^ self 
		forPharo12AndNewer: [ self isKindOf: PackageTag ] 
		forPharo11: [ self isKindOf: RPackageTag ]
]

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
Object >> packageOrganizer [
	<gtPharoPatch: #Pharo12>
	
	^ self class packageOrganizer
]
