Class {
	#name : #GtNotificationBadgeByScripterExamples,
	#superclass : #GtNotificationByScripterExamples,
	#category : #'GToolkit-Notifications-Examples'
}

{ #category : #'examples - actions' }
GtNotificationBadgeByScripterExamples >> clickOnBadgeIn: aScripterOrStep do: aBlock [
	<gtExample>
		
	aScripterOrStep 
		substep: 'Notification dropdown'
		do: [ :aStep | 
		
			aStep click 
				label: 'Click on notification badge';
				onSpaceRoot;
				onChildAt: 2.
				
			aStep wait forEmptySpaceTaskQueue.
			
			aBlock cull: aStep ].
	
	^ aScripterOrStep
]

{ #category : #'examples - targets' }
GtNotificationBadgeByScripterExamples >> closeButtonTarget: aStep [
	<gtExample>
	aStep 
		onChildOfClass: GtNotificationBorderElement;
		onChildNamed: #closeButton
]

{ #category : #'examples - inform message' }
GtNotificationBadgeByScripterExamples >> closeInformNotification [
	<gtExample>
	| aScripter |
	aScripter := self displayInformNotification.
		
	aScripter 
		substep: 'Close notification'
		do: [ :aStep | 
			aStep click 
				label: 'Click on close notification button';
				onTarget: [ :theClick | 
					self 
						dropdownListItemElementTarget: theClick 
						itemClass: GtNotificationMessageElement.
					self 
						closeButtonTarget: theClick ].
			aStep wait forEmptySpaceTaskQueue.
			
			aStep check 
				label: 'Check empty list';
				value: [ :aList | 
					aList listElement items size ]
				equals: 1;
				onTarget: [ :theCheck | 
					self dropdownListElementTarget: theCheck ]
			
			 ].
	
	^ aScripter syncContinue
]

{ #category : #'examples - inform message' }
GtNotificationBadgeByScripterExamples >> displayInformNotification [
	<gtExample>
	| aScripter |
	aScripter := self informInSpace.
	
	self clickOnBadgeIn: aScripter do: [ :aStep |
		aStep check
			label: 'Check anchored badge list';
			satisfies: [ :aList | aList listElement items size = 1 ];
			onTarget: [ :theCheckStep |
				self dropdownListElementTarget: theCheckStep ].

		aStep check
			label: 'Check anchored badge label';
			satisfies: [ :aBadge | 
				(aBadge isKindOf: BrBadge) and: [
					aBadge label asString = '1' ] ];
			onTarget: [ :theCheckStep |
				self dropdownBadgeElementTarget: theCheckStep ] ].
	
	^ aScripter syncContinue
]

{ #category : #'examples - inform message' }
GtNotificationBadgeByScripterExamples >> dropdownBadgeElementTarget: aStep [
	<gtExample>
	aStep
		onSpaceRoot;
		onBreadthFirstChildOfClass: BrAnchoredElement;
		onBreadthFirstChildOfClass: BrBadge.
	^ aStep
]

{ #category : #'examples - inform message' }
GtNotificationBadgeByScripterExamples >> dropdownListElementTarget: aStep [
	<gtExample>
	aStep
		onSpaceRoot;
		onBreadthFirstChildOfClass: BrAnchoredElement;
		onBreadthFirstChildOfClass: GtNotificationsListElement.
	^ aStep
]

{ #category : #'examples - inform message' }
GtNotificationBadgeByScripterExamples >> dropdownListItemElementTarget: aStep itemClass: aClass [
	<gtExample>
	self dropdownListElementTarget: aStep.
	aStep
		onBreadthFirstChildOfClass: aClass.
	^ aStep
]

{ #category : #'examples - inform message' }
GtNotificationBadgeByScripterExamples >> informCode [
	<gtExample>
	^ '[ BlBlocUIManagerNotification
	requestOrNil: #inform:
	with: { ''Example information'' } ] 
on: BlBlocUIManagerNotification 
do: [ :aNotification | 
	GtNotificationForwarder
		spaceDo: [ :aSpace | 
			aSpace root userData at: #exampleSpaceId put: aSpace id ].
	aNotification pass.
]'
]

{ #category : #'examples - inform message' }
GtNotificationBadgeByScripterExamples >> informInSpace [
	<gtExample>
	| aScripter |
	aScripter := self scripterForBlock: [
		self snippetWithInformCode ].
		
	aScripter check
		label: 'Check space height';
		value: [ :aSpace | aSpace height ]
		equals: 600;
		onSpace.

	aScripter check
		label: 'Check space width';
		value: [ :aSpace | aSpace width ]
		equals: 800;
		onSpace.
		
	aScripter 
		substep: 'Play code snippet'
		do: [ :aStep | 
		
			aStep click 
				label: 'Click on play button';
				onGtPharoSnippetPlayButton.
				
			aStep wait forEmptySpaceTaskQueue.
			
			aStep check 
				label: 'Check space ID stored in space root element';
				value: [ :aSpace | 
					aSpace root userData at: #exampleSpaceId ifAbsent: [ nil ] ]
				equals: [ :aSpace | aSpace id ];
				onSpace.
			
			aStep check
				label: 'Check two elements in space';
				value: [ :aRootElement | aRootElement children size ]
				equals: 2;
				onSpaceRoot.

			aStep check
				label: 'Check notification badge existence';
				value: [ :aRootElement | (aRootElement childAt: 2) class ]
				equals: GtNotificationsBadgeElement;
				onSpaceRoot.
								
			aStep check
				label: 'Check notification badge label';
				satisfies: [ :aBadgeElement |
					aBadgeElement badgeElement label asString = '1' ];
				onSpaceRoot;
				onChildAt: 2 ].
	
	^ aScripter syncContinue
]

{ #category : #'examples - coder' }
GtNotificationBadgeByScripterExamples >> pharoSnippetCoder [
	<gtExample>
	| aCoder |
	aCoder := GtPharoSnippetCoder new.
	^ aCoder
]

{ #category : #'examples - inform message' }
GtNotificationBadgeByScripterExamples >> snippetWithInformCode [
	<gtExample>
	| aCoder |
	aCoder := self pharoSnippetCoder.
	aCoder forSource: self informCode.
	^ aCoder
]
