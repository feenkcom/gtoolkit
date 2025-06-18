Extension { #name : #SmalltalkImage }

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
SmalltalkImage >> createRbNamespace [
	^ self 
		forPharo12: [ GtRBNamespace ] 
		forPharo11AndPharo10: [ RBClassModelFactory rbNamespace ]
]
