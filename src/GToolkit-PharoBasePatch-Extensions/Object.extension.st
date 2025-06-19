Extension { #name : #Object }

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
Object >> packageOrganizer [
	<gtPharoPatch: #Pharo12>
	
	^ self 
		forPharo12: [
			self class packageOrganizer ] 
		forPharo11AndPharo10: [ 
			RPackage organizer ]
]
