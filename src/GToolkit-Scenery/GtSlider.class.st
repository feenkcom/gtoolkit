Class {
	#name : #GtSlider,
	#superclass : #BrStencil,
	#instVars : [
		'slides',
		'currentSlide',
		'slidesContainer',
		'slideElement',
		'nextArrow',
		'previousArrow',
		'arrowsAreVisible'
	],
	#category : #'GToolkit-Scenery'
}

{ #category : #accessing }
GtSlider >> addSlide: aSlide [
	slides add: aSlide
]

{ #category : #'api - instantiation' }
GtSlider >> create [
	| previousElement nextElement container |
	
	container := BlElement new.
	container constraintsDo: [:c | c horizontal matchParent. c vertical matchParent];
		layout: BlLinearLayout vertical.
	slideElement := BlElement new
		constraintsDo: [:c | c horizontal matchParent. c vertical matchParent ];
		layout: BlLinearLayout horizontal.
	previousElement := BlElement new 
		constraintsDo: [:c | c horizontal exact: 24. c vertical matchParent ];
		when: BlClickEvent do: [:e | self previousStep ];
		layout: BlLinearLayout new alignCenter.
	previousArrow := BrButton new
		size: 12 @ 24;
		geometry:
			(BlPolygon
				vertices:
					{(12 @ 0).
					(0 @ 12).
					(12 @ 24)});
		background: ((Color fromHexString: #BDBDBD) alpha: 0.5).
	previousElement addChild: previousArrow.
	nextElement := BlElement new 
		constraintsDo: [:c | c horizontal exact: 24. c vertical matchParent ];
		when: BlClickEvent do: [:e | self nextStep ];
		layout: BlLinearLayout new alignCenter.
	nextArrow := BrButton new
		size: 12 @ 24;
		geometry:
			(BlPolygon
				vertices:
					{(0 @ 0).
					(12 @ 12).
					(0 @ 24)});
		background: ((Color fromHexString: #BDBDBD) alpha: 0.5).
	nextElement addChild: nextArrow.
	slidesContainer := BlElement new 
		constraintsDo: [:c | c horizontal matchParent. c vertical matchParent ];
		layout: BlLinearLayout horizontal;
		addChild: previousElement;
		addChild: slideElement;
		addChild: nextElement.
	self showSlide: self slides first.
	container addChild: slidesContainer.
	container addChild: self slidesDropdown.
	
	container addShortcut: (BlShortcut new
		repeatable: false;
		combination: BlKeyCombination builder alt arrowRight build;
		action: [ self nextStep ]).
	container addShortcut: (BlShortcut new
		repeatable: false;
		combination: BlKeyCombination builder alt arrowLeft build;
		action: [ self previousStep ]).
	^ container
]

{ #category : #accessing }
GtSlider >> gtSlidesFor: aView [
	<gtView>
	^ aView list 
		title: 'Slides';
		items: [ self slides ];
		itemFormat: #name
]

{ #category : #'api - instantiation' }
GtSlider >> hasNextSlide [
	^ self slides last ~= currentSlide
]

{ #category : #'api - instantiation' }
GtSlider >> hasPreviousSlide [
	^ self slides first ~= currentSlide
]

{ #category : #initialization }
GtSlider >> initialize [
	super initialize.
	slides := OrderedCollection new.
	arrowsAreVisible := false
]

{ #category : #accessing }
GtSlider >> makeArrowsVisible [
	arrowsAreVisible := true
]

{ #category : #'api - instantiation' }
GtSlider >> nextStep [
	self hasNextSlide ifFalse: [ ^ self ].
	currentSlide nextStepWith: self
]

{ #category : #'api - instantiation' }
GtSlider >> openInSpace [ 
	| space |
	space := BlSpace new.
	space extent: 800@500.
	space root addChild: self asElement.
	space root addShortcut: (BlShortcut new 
		repeatable: false;
		combination: (BlSingleKeyCombination new key: BlKeyboardKey pageDown);
			action: [ self nextStep ]).
	space root addShortcut: (BlShortcut new 
		repeatable: false;
		combination: (BlSingleKeyCombination new key: BlKeyboardKey pageUp);
			action: [ self previousStep ]).
	space show
]

{ #category : #'api - instantiation' }
GtSlider >> previousStep [
	self hasPreviousSlide ifFalse: [ ^ self ].
	currentSlide previousStepWith: self
]

{ #category : #'api - instantiation' }
GtSlider >> showSlide: aSlide [
	| slideContentElement |
	currentSlide = aSlide
		ifTrue: [ ^ self ].
	slideContentElement := aSlide asCachedElement.
	slideElement removeChildren.
	slideElement addChild: slideContentElement.
	currentSlide := aSlide.
	self updateArrows
]

{ #category : #'api - instantiation' }
GtSlider >> showSlideAfter: aSlide [
	self showSlide: (self slides after: currentSlide)
]

{ #category : #'api - instantiation' }
GtSlider >> showSlideBefore: aSlide [
	self showSlide: (self slides before: currentSlide)
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
	| dropdown container aToolbar |
				
	dropdown := BrDropdown new.
	container := BlElement new.
	container 
				layout: BlFlowLayout new;
				constraintsDo: [:c |
					c vertical fitContent. c horizontal matchParent ];
				padding: (BlInsets all: 10).
	self slides do: [:each | 
			container addChild: (each asCachedElement asSpartaForm asElement asPannableElement
				background: Color white;
				look: BrShadowLook new;
				margin: (BlInsets all: 10);
				constraintsDo: [ :c | c vertical exact: 100. c horizontal exact: 150 ];
				when: BlClickEvent do: [:e | self showSlide: each])
		 ].
	^ dropdown
		layout: BlLinearLayout vertical;
		constraintsDo: [ :c | 
			c horizontal fitContent.
			c vertical fitContent.
			c linear horizontal alignRight ];
		padding: (BlInsets all: 10);
		in: [ :aDropdown | 
			aDropdown
				toggle: [ BrButton new
						look: BrGlamorousButtonWithIconLook;
						icon: (BrGlamorousIcons hamburger asElement) ] ];
		popup: [ 
			aToolbar := BrToolbar new.
			aToolbar look: BrGlamorousToolbarLook.

			aToolbar addItem: (BrToggle new 
					beSmall;
					look: BrGlamorousButtonWithIconLook + BrGlamorousToggleBackgroundLook;
					icon: (BrGlamorousIcons edit asElement);
					when: BrToggleActivatedEvent do: [ :anEvent | 
						arrowsAreVisible := true.
						self updateArrows.
						 ];
					when: BrToggleDeactivatedEvent do: [ :anEvent | 
						arrowsAreVisible := false.
						self updateArrows. ]).
			BlElement new 
				size: 400@250;
				layout: BlLinearLayout vertical;
				addChild: (container asScrollableElement);
				addChild: aToolbar.
			  ];
		look: BrGlamorousDropdownLook new
]

{ #category : #accessing }
GtSlider >> updateArrows [
	(arrowsAreVisible and: [ self hasPreviousSlide ])
		ifTrue: [ previousArrow visibility: BlVisibility visible ]
		ifFalse: [ previousArrow visibility: BlVisibility hidden ].
	(arrowsAreVisible and: [ self hasNextSlide ])
		ifTrue: [ nextArrow visibility: BlVisibility visible ]
		ifFalse: [ nextArrow visibility: BlVisibility hidden ]
]
