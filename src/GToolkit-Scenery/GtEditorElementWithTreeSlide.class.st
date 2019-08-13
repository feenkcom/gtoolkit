Class {
	#name : #GtEditorElementWithTreeSlide,
	#superclass : #GtSlide,
	#category : #'GToolkit-Scenery'
}

{ #category : #accessing }
GtEditorElementWithTreeSlide >> create [
	| container element preview |
	container := BlElement new 
   	constraintsDo: [:c |
   		c vertical matchParent.
   		c horizontal matchParent ];
		layout: BlLinearLayout vertical.
	element := GtWhatMakesBlocSpecialExplanation new editorOnSampleText
		constraintsDo: [:c |
			c vertical matchParent.
			c horizontal matchParent. ];
		margin: (BlInsets all: 10);
		padding: (BlInsets all: 10);
		look: BrShadowLook;
		background: Color white;
		addShortcut: (BlShortcut new
			combination: BlKeyCombination primaryG;
			action: [ 
				| m |
				preview removeChildren. 
				m := GtMondrian new.
				element paintEditorElementsWith: m.
				preview addChild: (m asElement) ]).
	container addChild: element.
	preview := BlElement new
		constraintsDo: [:c |
			c vertical matchParent.
			c horizontal matchParent ].
	container addChild: preview.
	^ container
]
