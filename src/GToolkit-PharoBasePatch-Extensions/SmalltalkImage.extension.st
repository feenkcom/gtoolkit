Extension { #name : #SmalltalkImage }

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
SmalltalkImage >> createRbNamespace [
	^ self 
		forPharo12AndNewer: [ GtRBNamespace ] 
		forPharo11: [ RBClassModelFactory rbNamespace ]
]
