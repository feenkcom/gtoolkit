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
		constraintsDo: [:c | c horizontal exact: 30. c vertical matchParent ];
		when: BlClickEvent do: [:e | self showPreviousSlide ].
	nextElement := BlElement new 
		constraintsDo: [:c | c horizontal exact: 30. c vertical matchParent ];
		when: BlClickEvent do: [:e | self showNextSlide ].
	slidesContainer := BlElement new 
		constraintsDo: [:c | c horizontal matchParent. c vertical matchParent ];
		layout: BlLinearLayout horizontal;
		addChild: previousElement;
		addChild: slideElement;
		addChild: nextElement";
		addChild: self slidesDropdown".
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
			c vertical fitContent ];
		in: [ :aDropdown | 
			aDropdown
				toggle: [ BrButton new
						look: BrGlamorousButtonWithIconLook;
						padding:
							(BlInsets
								top: 6
								right: 8
								bottom: 6
								left: 15);
						icon:
							(BlElement new
								size: 8 @ 8;
								geometry:
									(BlPolygon
										vertices:
											{(0 @ 0).
											(8 @ 0).
											((8 / 2) rounded @ 8)});
								background: Color black;
								margin: (BlInsets left: 4 right: 4);
								constraintsDo: [ :c | c linear vertical alignCenter ]) ] ];
		popup: [ aList
				hExact: 150;
				vExact: 80 ];
		look: BrGlamorousDropdownLook new
]
