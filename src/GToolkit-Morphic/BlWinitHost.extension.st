Extension { #name : #BlWinitHost }

{ #category : #'*GToolkit-Morphic' }
BlWinitHost >> openMorphicWorld [
	self class hdpiRenderer
		ifTrue: [ #GlutinWorldSpartaRenderer asClass openMorphicWorld ]
		ifFalse: [ GlutinWorldOpenGLRenderer openMorphicWorld ]
]
