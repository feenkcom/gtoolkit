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
	| previousElement nextElement container |

	container := BlElement new.
	container constraintsDo: [:c | c horizontal matchParent. c vertical matchParent.];
		layout: BlLinearLayout vertical.
	slideElement := BlElement new
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
		addChild: previousElement;
		addChild: slideElement;
		addChild: nextElement.
	self showSlide: self slides first.
	container addChild: slidesContainer.
	container addChild: self slidesDropdown.
	^ container
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
	slideContentElement := aSlide asCachedElement.
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

{ #category : #'api - instantiation' }
GtSlider >> slidesDropdown [
	| dropdown aList |
	dropdown := BrDropdown new.
	aList := BrSimpleList new.
	aList
		stencil: [ :each :index | 
			BlTextElement new
				text: each name asRopedText;
				constraintsDo: [ :c | c horizontal matchParent ];
				padding: (BlInsets all: 5);
				when: BlClickEvent
					do: [ :anEvent | 
					anEvent consumed: true.
					aList selectOne: index ] ];
		display: self slides;
		when: BrSelectionChanged
			do: [ :anEvent | 
			anEvent
				selectedDo: [ :aSlide | 
					dropdown collapse.
					self showSlide: (self slides at: aSlide first) ] ];
		yourself.
	^ dropdown
		layout: BlLinearLayout horizontal;
		constraintsDo: [ :c | 
			c horizontal fitContent.
			c vertical fitContent.
			c linear horizontal alignRight ];
		padding: (BlInsets all: 10);
		in: [ :aDropdown | 
			aDropdown
				toggle: [ BrButton new
						look: BrGlamorousButtonWithIconLook;
						icon: 	(BrGlamorousIcons hamburger asElement) ] ];
		popup: [ aList
				hExact: 250;
				vExact: 250 ];
		look: BrGlamorousDropdownLook new
]
