Class {
	#name : #GtRawViewsSlide,
	#superclass : #GtSlide,
	#category : #'GToolkit-Scenery'
}

{ #category : #'api - instantiation' }
GtRawViewsSlide >> create [
	| container |
	container := BlElement new
		constraintsDo: [:c |
			c horizontal fitContent.
			c vertical fitContent ];
		layout: (BlGridLayout new columnCount: 3).
	{21/2 . 
	Color red . 
	FileLocator imageDirectory asFileReference .
	FileLocator imageDirectory asFileReference / 'dx' / 'gtoolkit.png' .
	GtGraphCircleEnclosureExamples new enclosureWithThreeCircles .
	GtWhatMakesBlocSpecialExplanation new sampleText} do: [:x | 
		container addChild: (((x gtRawFor: GtPhlowView empty) 
			asElementDo: [:e | 
				BlElement new 
					look: BrShadowLook; 
					background: Color white;
					margin: (BlInsets all: 20);
					addChild: e]) size: 400@400) ].
	^ container asPannableElement
]
