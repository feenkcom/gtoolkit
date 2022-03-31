Extension { #name : #AbstractWorldRenderer }

{ #category : #'*GToolkit-Morphic' }
AbstractWorldRenderer class >> openMorphicWorld [
	| aRenderer aWorld |
	
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
