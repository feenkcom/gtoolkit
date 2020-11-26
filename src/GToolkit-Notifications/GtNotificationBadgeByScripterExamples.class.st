Class {
	#name : #GtNotificationBadgeByScripterExamples,
	#superclass : #GtNotificationByScripterExamples,
	#category : #'GToolkit-Notifications-Examples'
}

{ #category : #'examples - inform message' }
GtNotificationBadgeByScripterExamples >> informCode [
	<gtExample>
	^ 'self inform: ''Example information'''
]

{ #category : #accessing }
GtNotificationBadgeByScripterExamples >> informInSpace [
	<gtExample>
	| aScripter |
	aScripter := self scripterForBlock: [
		self snippetWithInformCode ].
		
	aScripter 
		substep: 'Play code snippet'
		do: [ :aStep | 
		
			aStep click 
				label: 'Click on play button';
				onGtPharoSnippetPlayButton.
				
			aStep wait forEmptySpaceTaskQueue.
			
			aStep check
				label: 'Check notification badge existence';
				satisfies: [ :aRootElement |
					aRootElement children size = 2 and: [
						(aRootElement childAt: 2) isKindOf: GtNotificationsBadgeElement ] ];
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
