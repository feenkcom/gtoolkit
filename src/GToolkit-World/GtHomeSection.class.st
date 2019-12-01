Class {
	#name : #GtHomeSection,
	#superclass : #BrStencil,
	#instVars : [
		'priority'
	],
	#category : #'GToolkit-World'
}

{ #category : #'instance creation' }
GtHomeSection >> newCard [
	^ BrCard new
		look: "(BrShadowLook new) +"
			(BrDescriptionLook new readonly glamorousRegularFont descriptionDo: [:e | e padding: (BlInsets all: 10)]) +
			BrIconLook new +
			(BrGlamorousButtonExteriorLook new backgroundPaint: BrGlamorousColors secondaryHeaderBackgroundColor);
		layout: (BlLinearLayout horizontal alignCenter cellSpacing: 0);
		geometry: (BlRectangle cornerRadius: 4);
		constraintsDo: [ :c |
			c horizontal exact: 300.
			c vertical exact: 150 ];
		margin: (BlInsets top: self spaceGap * 2 left: self spaceGap * 2 bottom: self spaceGap * 2 right: self spaceGap * 2)
]

{ #category : #initialization }
GtHomeSection >> newCardWithTitle: aTitle description: aDescription picture: anElementOrStencil action: aBlock [ 	
	^ self newCard
		title: aTitle;
		description: ((aTitle asRopedText fontSize: 18) append: ((String cr, String cr) asRopedText); append: (aDescription asRopedText "foreground: Color gray; "fontSize: 14));
		picture: (BlElement new 
			constraintsDo: [ :c |
				c horizontal matchParent.
				c vertical matchParent ];
			layout: BlLinearLayout new;
			addChild: (anElementOrStencil asElement background: Color white; size: 300@300; asScalableElement);
			margin: (BlInsets all: 10);
			background: Color white;
			geometry: (BlRectangle cornerRadius: 4);
			look:" BrGlamorousButtonExteriorLook new + "BrShadowLook new;
"			border: (BlBorder paint: BrGlamorousColors defaultButtonBorderColor); "
			preventMeAndChildrenMouseEvents);
		action: aBlock
]

{ #category : #'instance creation' }
GtHomeSection >> newCardsContainer [
	^ BlElement new
		layout: BlFlowLayout new;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical fitContent ];
		padding: (BlInsets all: 0)
]

{ #category : #'instance creation' }
GtHomeSection >> newHeaderLabel: aString [

	^ BrLabel new
		look: (BrGlamorousLabelLook new foreground: Color black; fontSize: 20);
		padding: (BlInsets left: (self spaceGap*2));
		margin: (BlInsets top: self spaceGap*2 bottom: 0);
		text: aString
]

{ #category : #'instance creation' }
GtHomeSection >> newSectionContainer [
	^ BlElement new
		layout: BlLinearLayout vertical;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical fitContent ]
]

{ #category : #accessing }
GtHomeSection >> priority [
	^ priority
]

{ #category : #accessing }
GtHomeSection >> priority: aNumber [
	priority := aNumber
]

{ #category : #initialization }
GtHomeSection >> showSpaceWithTitle: aString with: anElement from: anotherElement [
	| aSpace |
	aSpace := BlSpace new.
	aSpace title: aString.
	aSpace extent: 1200@600.
	aSpace addChild: anElement asElement.
	aSpace withHalos.
	anotherElement showSpace: aSpace
]

{ #category : #initialization }
GtHomeSection >> spaceGap [
	^ 10
]
