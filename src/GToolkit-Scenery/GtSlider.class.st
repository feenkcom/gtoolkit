Class {
	#name : #GtSlider,
	#superclass : #BrStencil,
	#instVars : [
		'slides',
		'currentSlide',
		'slidesContainer',
		'slideElement'
	],
	#category : #'GToolkit-Scenery'
}

{ #category : #'api - instantiation' }
GtSlider >> create [
	| previousElement nextElement |
	slideElement := BlElement new
		look: BrShadowLook;
		background: Color white;	
		padding: (BlInsets all: 5);
		constraintsDo: [:c | c horizontal matchParent. c vertical matchParent ];
		layout: BlLinearLayout horizontal.
	previousElement := BlElement new 
		constraintsDo: [:c | c horizontal exact: 20. c vertical matchParent ];
		when: BlClickEvent do: [:e | self showPreviousSlide ].
	nextElement := BlElement new 
		constraintsDo: [:c | c horizontal exact: 20. c vertical matchParent ];
		when: BlClickEvent do: [:e | self showNextSlide ].
	slidesContainer := BlElement new 
		constraintsDo: [:c | c horizontal matchParent. c vertical matchParent ];
		layout: BlLinearLayout horizontal;
		padding: (BlInsets top: 20 bottom: 20);
		addChild: previousElement;
		addChild: slideElement;
		addChild: nextElement.
	self showSlide: self slides first.
	^ slidesContainer
]

{ #category : #'api - instantiation' }
GtSlider >> hasNextSlide [
	^ self slides last ~= currentSlide
]

{ #category : #'api - instantiation' }
GtSlider >> hasPreviousSlide [
	^ self slides first ~= currentSlide
]

{ #category : #'api - instantiation' }
GtSlider >> showNextSlide [
	self hasNextSlide ifFalse: [ ^ self ].
	self showSlide: (self slides after: currentSlide)
]

{ #category : #'api - instantiation' }
GtSlider >> showPreviousSlide [
	self hasPreviousSlide ifFalse: [ ^ self ].
	self showSlide: (self slides before: currentSlide)
]

{ #category : #'api - instantiation' }
GtSlider >> showSlide: aSlide [
	| slideContentElement |
	slideContentElement := aSlide asElement.
	slideElement removeChildren.
	slideElement addChild: slideContentElement.
	currentSlide := aSlide
]

{ #category : #accessing }
GtSlider >> slides [
	^ slides
]

{ #category : #accessing }
GtSlider >> slides: anObject [
	slides := anObject
]
