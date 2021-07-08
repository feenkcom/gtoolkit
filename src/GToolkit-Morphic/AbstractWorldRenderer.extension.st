Extension { #name : #AbstractWorldRenderer }

{ #category : #'*GToolkit-Morphic' }
AbstractWorldRenderer class >> openMorphicWorld [
	| aRenderer aWorld |
	
	self class environment
		at: #ThreadedFFIMigration
		ifPresent: [ :aThreadedFFIMigration |
			aThreadedFFIMigration threadedFFIAvailable ifFalse: [
				self error: 'Morphic World can only be run when Threaded FFI is available.  See the class comments in ThreadedFFIMigration for more information.' ] ].

	aWorld := self currentWorld.
	
	aWorld worldState worldRenderer class = self
		ifTrue: [ ^ self ].
	
	aRenderer := self forWorld: aWorld.
	
	World == aWorld
		ifTrue:[ MainWorldRenderer := aRenderer ].
	
	aWorld worldState worldRenderer: aRenderer.
		
	WorldMorph currentWorld ifNotNil: [:world | world restoreMorphicDisplay].
	WorldMorph extraWorldList do: #restoreMorphicDisplay.

	SystemProgressMorph enable
]
