Class {
	#name : #GtHomeSection,
	#superclass : #BrStencil,
	#instVars : [
		'priority'
	],
	#category : #'GToolkit-World-Sections'
}

{ #category : #testing }
GtHomeSection class >> isAbstract [ 
	^ self name = #GtHomeSection 
]

{ #category : #'instance creation' }
GtHomeSection >> newAddCardWithTooltip: aTooltip size: aPoint action: aBlock [
	| anAddButton |
		
	anAddButton := BrButton new
		aptitude: BrGlamorousButtonWithIconCircularAptitude;
		icon: (BrGlamorousVectorIcons add asElement 
			background: BrGlamorousColors defaultButtonBorderColor);
		label: aTooltip;
		beHuge;
		constraintsDo: [ :c | 
			c frame horizontal alignCenter.
			c frame vertical alignCenter ];
		action: aBlock.
	
	^ 	BrFrame new
			exact: aPoint;
			padding: (BlInsets all: 1);
			margin: (BlInsets top: self spaceGap left: 2 * self spaceGap bottom: self spaceGap right: 2 * self spaceGap);
			addChild: anAddButton
]

{ #category : #'instance creation' }
GtHomeSection >> newCard [
	self deprecated: 'not used'.
	^ self newCardWithoutIcon
		addAptitude: BrIconAptitude new +(BrShadowAptitude new width: 8; offset: 1@1; color: (Color r: 200 g: 200 b: 200 range: 255));
		yourself
]

{ #category : #'instance creation' }
GtHomeSection >> newCardWithTitle: aTitle description: aDescription action: aBlock [ 
	| cardElement |	
	self deprecated: 'not used'.
	cardElement := self newCardWithoutIcon
		title: aTitle;
		description: ((aTitle asRopedText fontSize: 16) 
			append: ((String cr, String cr) asRopedText); 
			append: (aDescription asRopedText "foreground: Color gray; "fontSize: 14)).
	cardElement action: aBlock.
		
	^ cardElement
]

{ #category : #'instance creation' }
GtHomeSection >> newCardWithTitle: aTitle description: aDescription picture: anElementOrStencil action: aBlock [ 
	self deprecated: 'not used'.
	^ self newCard
		title: aTitle;
		description: ((aTitle asRopedText fontSize: 18) 
			append: ((String cr, String cr) asRopedText); 
			append: (aDescription asRopedText "foreground: Color gray; "fontSize: 14));
		picture: (BlElement new 
			constraintsDo: [ :c |
				c horizontal matchParent.
				c vertical matchParent ];
			layout: BlLinearLayout new;
			addChild: (anElementOrStencil asElement background: Color white; size: 300@300; asScalableElement);
			margin: (BlInsets all: 10);
			background: Color white;
			geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
			aptitude:" BrGlamorousButtonExteriorLook new + "BrShadowAptitude new;
"			border: (BlBorder paint: BrGlamorousColors defaultButtonBorderColor); "
			preventMeAndChildrenMouseEvents);
		action: aBlock
]

{ #category : #'instance creation' }
GtHomeSection >> newCardWithoutIcon [
	^ BrCard new
		aptitude: (BrShadowAptitude new beLarge)+
			(BrDescriptionAptitude new readonly glamorousRegularFont descriptionDo: [:e | e padding: (BlInsets all: 10)]) +
			(BrGlamorousButtonExteriorAptitude new backgroundPaint: BrGlamorousColors secondaryHeaderBackgroundColor);
		layout: (BlLinearLayout horizontal alignCenter cellSpacing: 0);
		geometry: (BlRoundedRectangleGeometry cornerRadius: 2);
		constraintsDo: [ :c |
			c horizontal exact: 250.
			c vertical exact: 100 ];
		margin: (BlInsets top: self spaceGap left: self spaceGap * 2 bottom: self spaceGap right: self spaceGap * 2)
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
GtHomeSection >> newDocCardForClass: aClass [
	^ self
		newHeaderCardWithTitle: 'Doc'
		description: aClass name
		size: 150 @ 200
		content:
			((GtHomeDocumentCardElement forClass: aClass) matchParent)
		action: [ :card | 
			self
				showSpaceWithIcon: BrGlamorousIcons file
				title: aClass name
				with: (GtPager createWrappedOn: (
					(LeCoderCommentElement coderElementFor: aClass name) 
						withDefaultToolbar))
				from: card ]
]

{ #category : #'instance creation' }
GtHomeSection >> newHeaderCardWithTitle: aTitle description: aDescription size: aPoint content: anElement action: aBlock [
	| container |

	container := BrButton new
		size: aPoint;
		layout: BlLinearLayout vertical;
		aptitude: ((BrGlamorousButtonExteriorAptitude new 
			backgroundPaint: Color white;
			borderPaint: (Color transparent)) + BrGlamorousButtonWithLabelTooltipAptitude new + (BrShadowAptitude new beLarge));
		label: aDescription;
		padding: (BlInsets all: 1);
		margin: (BlInsets top: self spaceGap left: 2 * self spaceGap bottom: 2 * self spaceGap right: 2 * self spaceGap);
		geometry: (BlRoundedRectangleGeometry cornerRadius: 2);
		action: aBlock.

	^ container
		addChild: (anElement preventMeAndChildrenMouseEvents).
]

{ #category : #'instance creation' }
GtHomeSection >> newHeaderCardWithTitle: aTitle description: aDescription width: aWidth content: anElement action: aBlock [
	| container headerContainer |

	container := BrButton new
		constraintsDo: [:c | 
			c vertical fitContent.
			c horizontal exact: aWidth ]; 
		layout: BlLinearLayout vertical;
		background: Color red;
		aptitude: ((BrGlamorousButtonExteriorAptitude new
			backgroundPaint: Color white; 
			borderPaint: Color transparent) + BrGlamorousButtonWithLabelTooltipAptitude new + (BrShadowAptitude new beLarge));
		label: aDescription;
		padding: (BlInsets all: 1);
		margin: (BlInsets top: self spaceGap left: 2 * self spaceGap bottom: self spaceGap * 2 right: 2 * self spaceGap);
		geometry: (BlRoundedRectangleGeometry cornerRadius: 2);
		action: aBlock.

	headerContainer := BlElement new
		constraintsDo: [:c | c horizontal fitContent. c vertical fitContent ];
		layout: BlLinearLayout vertical;
		background: BrGlamorousColors defaultButtonBorderColor;
		addChild: (BrLabel new aptitude: (BrGlamorousLabelAptitude new fontSize: 10);
		text: aTitle).
	
	^ container"
		addChild: headerContainer preventMeAndChildrenMouseEvents; "
		addChild: (anElement preventMeAndChildrenMouseEvents).
]

{ #category : #'instance creation' }
GtHomeSection >> newInspectorCardForObject: anObject [
	^ self
		newHeaderCardWithTitle: 'Inspector'
		description: anObject gtDisplayString
		size: 200 @ 150
		content:
			(((GtInspector newOn: anObject)
				constraintsDo: [ :c |
					c horizontal exact: 400.
					c vertical exact: 300 ];
				asScalableElement)
					margin: (BlInsets top: 5))
		action: [ :card | 
			self
				showSpaceWithTitle: anObject gtDisplayString
				with: (GtPager createWrappedOn: (
					GtInspector newOn: anObject))
				from: card ]
]

{ #category : #'instance creation' }
GtHomeSection >> newLepiterPageCardForPage: aTargetPage withTitle: aCardTitle andDescription: aDescription [
	^ self
		newHeaderCardWithTitle: aCardTitle
		description: aDescription
		size: 200@150
		content:
			(BrLabel new
				text: aCardTitle;
				aptitude: BrGlamorousLabelAptitude new
					bold;
				padding: (BlInsets all: 20)) asScalableElement
		action: [ :card | 
			GtWorldUtility 
				showSpaceWithTitle: aTargetPage title
				inPagerWith: [ aTargetPage
					asLepiterPagePhlowTool asElementDo: [ :e | e ] ] asStencil
				from: card ]
]

{ #category : #'instance creation' }
GtHomeSection >> newLepiterPageCardForPageNamed: aPageTitle inDatabase: aDatabase withTitle: aCardTitle andDescription: aDescription [
	| startPage |
	startPage := aDatabase pageNamed: aPageTitle.
				
	^ self 
		newLepiterPageCardForPage: startPage 
		withTitle: aCardTitle 
		andDescription: aDescription
]

{ #category : #'instance creation' }
GtHomeSection >> newLepiterPageCardForPageNamed: aPageTitle inDatabaseNamed: aDatabaseName withTitle: aCardTitle andDescription: aDescription [
	| targetDatabase |
	targetDatabase := LeDatabasesRegistry default currentLoadedDefaultLogicalDatabase 
		databaseNamed: aDatabaseName.
				
	^ self 
		newLepiterPageCardForPageNamed: aPageTitle 
		inDatabase: targetDatabase
		withTitle: aCardTitle 
		andDescription: aDescription
]

{ #category : #'instance creation' }
GtHomeSection >> newLepiterPageCardForPageNamed: aPageTitle withTitle: aCardTitle andDescription: aDescription [				
	^ self 
		newLepiterPageCardForPageNamed: aPageTitle 
		inDatabase: LeDatabasesRegistry default currentLoadedDefaultLogicalDatabase 
		withTitle: aCardTitle 
		andDescription: aDescription
]

{ #category : #'instance creation' }
GtHomeSection >> newSectionButton [

	^ BrButton new
		padding: self newSectionTitlePaddingInsets
]

{ #category : #'instance creation' }
GtHomeSection >> newSectionButtonWithIcon: anIcon [

	^ self newSectionButton 
		aptitude: BrGlamorousButtonWithIconAptitude;
		icon: anIcon asElement
]

{ #category : #'instance creation' }
GtHomeSection >> newSectionContainer [
	^ BlElement new
		layout: BlLinearLayout vertical;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical fitContent ]
]

{ #category : #'instance creation' }
GtHomeSection >> newSectionTitle: aString [
	^ BrLabel new
		aptitude:
			(BrGlamorousLabelAptitude new
				foreground: Color gray;
				fontSize: 14);
		padding: self newSectionTitlePaddingInsets;
		text: aString
]

{ #category : #'instance creation' }
GtHomeSection >> newSectionTitleContainer [
	^ BrHorizontalPane new
		vFitContent;
		hFitContent.
]

{ #category : #'instance creation' }
GtHomeSection >> newSectionTitlePaddingInsets [
	^ BlInsets left: self sectionPaddingLeftInsets
]

{ #category : #'instance creation' }
GtHomeSection >> newShowCardWithTitle: aString slideshow: aSlideShowBlock description: aDescription [
	^ self
		newHeaderCardWithTitle: 'Slideshow'
		description: aDescription
		size: 200@150
		content:
			(aSlideShowBlock value slides first asElement
				size: 800@600;
				padding: (BlInsets all: 10);
				beInSingleCompositionLayer) asScalableElement
		action: [ :card | 
			self
				showSpaceWithTitle: aString
				with: aSlideShowBlock value
				from: card ]
]

{ #category : #'instance creation' }
GtHomeSection >> newToolCardWithTitle: aString icon: anElement action: aBlock description: aDescriptionString [
	| iconElement labelElement |
	iconElement := anElement margin: (BlInsets bottom: 5).
	labelElement := BrLabel new 
	    text: aString;
	    aptitude: (BrGlamorousLabelAptitude new fontSize: 14).
	^ BrButton new
		constraintsDo:[ :c | 
	        c horizontal exact: 120.
	        c vertical exact: 120 ];
		margin: (BlInsets top: 10 left: 20 bottom: 10 right: 20);
		action: aBlock;
		padding: (BlInsets all: 10);
		label: aDescriptionString;
		aptitude: (BrGlamorousButtonExteriorAptitude new + BrGlamorousButtonWithLabelTooltipAptitude new +(BrShadowAptitude new width: 8; offset: 1@1; color: (Color r: 200 g: 200 b: 200 range: 255)));
		geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
		layout: BlLinearLayout vertical alignCenter;
		addChild: iconElement;
		addChild: labelElement.
]

{ #category : #'instance creation' }
GtHomeSection >> newUrlCardWithTitle: aTitle description: aDescription url: aUrl [
	^ self
		newHeaderCardWithTitle: 'www'
		description: aDescription
		size: 200 @ 80
		content:
			(BlElement new
				constraintsDo: [ :c | 
					c horizontal matchParent.
					c vertical matchParent ];
				layout: BlLinearLayout vertical alignCenter;
				addChild:
					(BrLabel new
						text: aTitle;
						aptitude: BrGlamorousLabelAptitude);
				addChild:
					(BrLabel new
						text: aDescription;
						aptitude:
							(BrGlamorousLabelAptitude new
								fontSize: 10;
								foreground: Color gray)))
		action: [ :card | WebBrowser openOn: aUrl ]
]

{ #category : #accessing }
GtHomeSection >> priority [
	^ priority
]

{ #category : #accessing }
GtHomeSection >> priority: aNumber [
	priority := aNumber
]

{ #category : #accessing }
GtHomeSection >> sectionPaddingLeftInsets [
	^ self spaceGap * 2
]

{ #category : #'instance creation' }
GtHomeSection >> showSpaceWithIcon: anIcon title: aString with: aStencil from: anotherElement [
	^ GtWorldUtility 
		showSpaceWithIcon: anIcon 
		title: aString 
		with: aStencil
		from: anotherElement
]

{ #category : #'instance creation' }
GtHomeSection >> showSpaceWithTitle: aString with: aStencil from: anotherElement [
	^ GtWorldUtility 
		showSpaceWithTitle: aString 
		with: aStencil
		from: anotherElement
]

{ #category : #accessing }
GtHomeSection >> spaceGap [
	^ 10
]
