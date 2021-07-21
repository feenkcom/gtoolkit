Extension { #name : #RBProgramNode }

{ #category : #'*GToolkit-Pharo9-Deprecations' }
RBProgramNode >> isSelfOrSuper [
	^ self isSelfOrSuperVariable
]

{ #category : #'*GToolkit-Pharo9-Deprecations' }
RBProgramNode >> isTemp [
	^ self isTempVariable
]
