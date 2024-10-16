Extension { #name : #RBSequenceNode }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
RBSequenceNode >> defines: aName [
	^ temporaries anySatisfy: [ :each | each name sameContentAs: aName ]
]

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
RBSequenceNode >> removeTemporaryNamed: aName [
	temporaries := temporaries reject: [ :each | each name sameContentAs: aName ]
]
