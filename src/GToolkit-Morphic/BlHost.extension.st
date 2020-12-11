Extension { #name : #BlHost }

{ #category : #'*GToolkit-Morphic' }
BlHost >> openMorphicWorld [
	"We still want to support morphic world. The opening of the morphic world should be dispatched via
	bloc host as the world should be opened in a window of the same framework (Glutin, SDL2, etc) as Bloc.
	By default I do nothing"
]
