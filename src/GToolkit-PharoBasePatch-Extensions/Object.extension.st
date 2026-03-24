Extension { #name : #Object }

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
Object >> isPharoPackageModel [
	^ self isKindOf: Package 
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
