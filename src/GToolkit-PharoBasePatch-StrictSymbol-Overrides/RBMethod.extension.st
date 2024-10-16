Extension { #name : #RBMethod }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
RBMethod >> literal: anObject containsReferenceTo: aSymbol [
	(anObject sameContentAs: aSymbol) ifTrue: [ ^ true ].
	anObject class = Array ifFalse: [ ^ false ].
	^ anObject
		anySatisfy: [ :each | self literal: each containsReferenceTo: aSymbol ]
]
