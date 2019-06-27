Class {
	#name : #GtConnectorForExampleSlide,
	#superclass : #GtSlide,
	#category : #'GToolkit-Scenery'
}

{ #category : #'api - instantiation' }
GtConnectorForExampleSlide >> create [
	^ GtInspector createOn: (BlFrameLayoutCompositionExamples>>#example) gtExample
]
