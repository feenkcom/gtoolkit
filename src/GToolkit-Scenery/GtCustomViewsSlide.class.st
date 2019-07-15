Class {
	#name : #GtCustomViewsSlide,
	#superclass : #GtSlide,
	#category : #'GToolkit-Scenery'
}

{ #category : #'api - instantiation' }
GtCustomViewsSlide >> create [
	| container |
	container := BlElement new
		constraintsDo: [:c |
			c horizontal fitContent.
			c vertical fitContent ];
		layout: (BlGridLayout new columnCount: 3).
	{(21/2 gtPreviewFor: GtPhlowView empty) . 
	(Color red gtPreviewFor: GtPhlowView empty) . 
	(FileLocator imageDirectory asFileReference gtItemsFor: GtPhlowView empty) . 
	(FileLocator imageDirectory asFileReference / 'dx' / 'gtoolkit.png' gtFigureFor: GtPhlowView empty) . 
	(GtGraphCircleNeighbourhoodExamples new emptyNeighborhoodWithThreeCirclesAndSpace gtPreviewFor: GtPhlowView empty) . 
	(GtWhatMakesBlocSpecialExplanation new sampleText gtTreeFor: GtPhlowView empty)} do: [:view | 
		container addChild: (( view
			asElementDo: [:e | 
				BlElement new 
					look: BrShadowLook; 
					background: Color white;
					margin: (BlInsets all: 20);
					addChild: e]) size: 400@400) ].
	^ container asPannableElement
]
