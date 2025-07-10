Extension { #name : #Object }

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
Object >> isPharoPackageModel [
	^ self 
		forPharo12: [ self isKindOf: Package ] 
		forPharo11AndPharo10: [ self isKindOf: RPackage ]
]

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
Object >> packageOrganizer [
	<gtPharoPatch: #Pharo12>
	
	^ self 
		forPharo12: [
			self class packageOrganizer ] 
		forPharo11AndPharo10: [ 
			RPackage organizer ]
]
