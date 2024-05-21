Extension { #name : #RBProgramNode }

{ #category : #'*GToolkit-PharoBasePatch-Deprecations' }
RBProgramNode >> isSelfOrSuper [
	<gtPharoPatch: #Pharo>
	
	^ self isSelfOrSuperVariable
]

{ #category : #'*GToolkit-PharoBasePatch-Deprecations' }
RBProgramNode >> isTemp [
	<gtPharoPatch: #Pharo>
	
	^ self isTempVariable
]
