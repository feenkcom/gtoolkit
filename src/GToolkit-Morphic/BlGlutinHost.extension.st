Extension { #name : #BlGlutinHost }

{ #category : #'*GToolkit-Morphic' }
BlGlutinHost >> openMorphicWorld [
	self class hdpiRenderer
		ifTrue: [ #GlutinWorldSpartaRenderer asClass openMorphicWorld ]
		ifFalse: [ GlutinWorldOpenGLRenderer openMorphicWorld ]
]
