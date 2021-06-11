Class {
	#name : #GtSceneDrillerExamples,
	#superclass : #Object,
	#category : #'GToolkit-SceneDriller-Examples'
}

{ #category : #examples }
GtSceneDrillerExamples >> drillerOnWorld [
	<gtExample>
	<noTest>
	| world |
	world := GtWorldElement new
		addEventHandler: GtSceneDrillerEventHandler new.
	world
		fireEvent:
			(GtSceneDrillerShowWish new
				elementToSelect: world children first children first;
				sceneExtent: 800 @ 600).
	^ world
]
