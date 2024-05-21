Extension { #name : #RBProgramNode }

{ #category : #'*GToolkit-Pharo9-Deprecations' }
RBProgramNode >> isSelfOrSuper [
	<gtPharoPatch: #Pharo>
	
	^ self isSelfOrSuperVariable
]

{ #category : #'*GToolkit-Pharo9-Deprecations' }
RBProgramNode >> isTemp [
	<gtPharoPatch: #Pharo>
	
	^ self isTempVariable
]
