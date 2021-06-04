"
I exemplify ${class:GtWorldTabElement}$.
"
Class {
	#name : #GtWorldTabElementExamples,
	#superclass : #Object,
	#category : #'GToolkit-World-Examples'
}

{ #category : #'examples - by scripter' }
GtWorldTabElementExamples >> showSpaceSelectScripter [
	| aScripter |
	<gtExample>
	
	aScripter := BlDevScripter new.
	aScripter element: GtWorldTabElement new.
	
	^ aScripter syncContinue
]

{ #category : #'examples - by scripter' }
GtWorldTabElementExamples >> showSpaceSelectScripter_01_addSpace [
	| aScripter |
	<gtExample>
	
	aScripter := self showSpaceSelectScripter.
	aScripter substep: 'Show space selected by default' do: [ :aStep | 
		aStep do
			label: 'Create and add space';
			action: [ :anActionScripter | anActionScripter element
				showSpace: (BlSpace new
					title: 'Tab 1';
					in: [ :aSpace | anActionScripter model: aSpace id ];
					rootDo: [ :aRoot | aRoot background: Color white ]) select: true ];
			onScripter.
			
		aStep wait forEmptySpaceTaskQueue.
	].

	^ aScripter syncContinue
]

{ #category : #'examples - by scripter' }
GtWorldTabElementExamples >> showSpaceSelectScripter_02_moveMouseOverSpaceCloseButton [
	| aScripter |
	<gtExample>
	
	aScripter := self showSpaceSelectScripter_01_addSpace.
	aScripter substep: 'Move mouse over the close button' do: [ :aStep | 
		aStep mouseMove by: 10@10.
		
		aStep mouseMoveOver
			onChildNamed: (GtWorldTabElement tabNameForSpaceId: aScripter model);
			onChildNamed: GtWorldTabElement spaceCloseButtonName ].

	^ aScripter syncContinue
]

{ #category : #'examples - by scripter' }
GtWorldTabElementExamples >> showSpaceSelectScripter_03_clickSpaceCloseButton [
	| aScripter |
	<gtExample>
	
	aScripter := self showSpaceSelectScripter_02_moveMouseOverSpaceCloseButton.
	aScripter substep: 'Mouse click the close button' do: [ :aStep | 
		aStep click
			onChildNamed: (GtWorldTabElement tabNameForSpaceId: aScripter model);
			onChildNamed: GtWorldTabElement spaceCloseButtonName.
		"We have to wait with timeout because due to the problem described in the issue one of the tasks stays forever in the queue
		https://github.com/feenkcom/gtoolkit/issues/1627"
		aStep wait forEmptySpaceTaskQueueTimeout: 1 second.
		
		aStep check
			label: 'Check that there is no more space tab';
			value: [ :theTabGroup | theTabGroup tabs size ] equals: 1;
			onChildFromMessage: #tabs
	].

	^ aScripter syncContinue
]

{ #category : #'examples - by scripter' }
GtWorldTabElementExamples >> showSpaceSelectScripter_04_checkSpaceGarbageCollected [
	| aScripter |
	<gtExample>
	
	aScripter := self showSpaceSelectScripter_03_clickSpaceCloseButton.
	aScripter substep: 'Check space garbage collected' do: [ :aStep | 		
		aStep do
			label: 'Clear scripter events and garbage collect';
			action: [ :_ |
				aScripter events removeAll.
				Smalltalk garbageCollect ].
		
		aStep check
			label: 'Check that there is no space with the stored id';
			value: [ :aStepScripter | BlSpace spaceWithId: aStepScripter model do: #yourself ] equals: nil;
			onScripter
	].

	^ aScripter syncContinue
]

{ #category : #'examples - show space' }
GtWorldTabElementExamples >> showSpaceSelect_ReleaseSpaceOnSelectedTabCloseAction [
	<gtExample>
	| aSpace aWorld aTabs |
	aSpace := BlSpace new.
	aWorld := GtWorldTabElement new.
	aWorld showSpace: aSpace select: true.
	aTabs := aWorld tabs.
	aTabs viewModel removeTab: (aTabs viewModel tabs at: 2).
	aSpace := aSpace asWeakReference.
	Smalltalk garbageCollect.
	self assert: (aSpace at: 1) equals: nil.
	^ aWorld
]

{ #category : #'examples - show space' }
GtWorldTabElementExamples >> showSpaceSelect_ReleaseSpaceOnUnselectedTabCloseAction [
	<gtExample>
	| aSpace aWorld aTabs |
	aSpace := BlSpace new.
	aWorld := GtWorldTabElement new.
	aWorld showSpace: aSpace select: false.
	aTabs := aWorld tabs.
	aTabs viewModel removeTab: (aTabs viewModel tabs at: 2).
	aSpace := aSpace asWeakReference.
	Smalltalk garbageCollect.
	self assert: (aSpace at: 1) equals: nil.
	^ aWorld
]
