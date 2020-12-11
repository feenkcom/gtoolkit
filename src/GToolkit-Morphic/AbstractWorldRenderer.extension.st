Extension { #name : #AbstractWorldRenderer }

{ #category : #'*GToolkit-Morphic' }
AbstractWorldRenderer class >> openMorphicWorld [
	| aRenderer aWorld |
	ThreadedFFIMigration threadedFFIAvailable ifFalse:
		[ self error: 'Morphic World can only be run when Threaded FFI is available.  See the class comments in ThreadedFFIMigration for more information.'].

	aWorld := self currentWorld.
	
	aWorld worldState worldRenderer class = self
		ifTrue: [ ^ self ].
	
	aRenderer := self forWorld: aWorld.
	
	aWorld isMainWorld 
		ifTrue:[ MainWorldRenderer := aRenderer ].
	
	aWorld worldState worldRenderer: aRenderer.
	Cursor currentCursor: Cursor currentCursor.
		
	WorldMorph currentWorld ifNotNil: [:world | world restoreMorphicDisplay].
	WorldMorph extraWorldList do: #restoreMorphicDisplay.

	SystemProgressMorph enable
]
