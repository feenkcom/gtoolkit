Class {
	#name : #GtComponentsSlide,
	#superclass : #GtSlide,
	#category : #'GToolkit-Scenery'
}

{ #category : #'api - instantiation' }
GtComponentsSlide >> create [
	| container |
	container := BlElement new
		constraintsDo: [:c |
			c horizontal fitContent.
			c vertical fitContent ];
		layout: (BlGridLayout new columnCount: 3).
	{'Inspector' . 'Playground' . 'Debugger' . 'Coder' . 'Documenter' . 'Spotter' . 'Transcript' .
	'Examples' . 'Constrainer' . 'Phlow' . 'Releaser' . 'Visualizer' . 'Completer' .
	'GT4SmaCC' . 'GT4Famix3' . 'GT4PetitParser2'} do: [:component | 
		container addChild: (BlTextElement new text: (component asLowercase asRopedText fontName: 'Helvetica Neue'; fontSize: 30; bold); margin: (BlInsets all: 20)) ].
	^ container asPannableElement
]
