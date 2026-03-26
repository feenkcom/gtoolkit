Extension { #name : #OCProgramNode }

{ #category : #'*GToolkit-PharoBasePatch-Deprecations' }
OCProgramNode >> isSelfOrSuper [
	<gtPharoPatch: #Pharo>
	
	^ self isSelfOrSuperVariable
]

{ #category : #'*GToolkit-PharoBasePatch-Deprecations' }
OCProgramNode >> isTemp [
	<gtPharoPatch: #Pharo>
	
	^ self isTempVariable
]
