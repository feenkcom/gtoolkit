Class {
	#name : #GtSpotterSlide,
	#superclass : #GtSlide,
	#category : #'GToolkit-Scenery'
}

{ #category : #'api - instantiation' }
GtSpotterSlide >> create [
	| aSpotter aSpotterElement | 
	aSpotter := GtSpotter new.
	aSpotterElement := GtSpotterElementWithPreview new.
	aSpotterElement spotterModel: aSpotter.
	aSpotterElement searchField requestFocus.
	aSpotterElement 
		look: BrShadowLook;
		margin: (BlInsets all: 10).
	^ aSpotterElement
]
