"
I exemplify {{gtClass:GtWorldTabElement}}.

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
	
	aScripter := BlScripter new.
	aScripter element: GtWorldTabElement new.
	
	^ aScripter
]

{ #category : #'examples - by scripter' }
GtWorldTabElementExamples >> showSpaceSelectScripter_01_addSpace [
	| aScripter |
	<gtExample>

	aScripter := self showSpaceSelectScripter.
	aScripter do
		label: 'Show space selected by default';
		action: [ :anActionScripter | anActionScripter element
			showSpace: (BlSpace new
				title: 'Tab 1';
				in: [ :aSpace | anActionScripter model: aSpace id ];
				rootDo: [ :aRoot | aRoot background: Color white ]) select: true ];
		onScripter;
		play.

	^ aScripter
]

{ #category : #'examples - by scripter' }
GtWorldTabElementExamples >> showSpaceSelectScripter_02_moveMouseOverSpaceCloseButton [
	| aScripter |
	<gtExample>
	
	aScripter := self showSpaceSelectScripter_01_addSpace.
	
	aScripter mouseMove by: 10@10; play.
	
	aScripter mouseMoveOver
		label: 'Move mouse over the close button';
		id: (GtWorldTabElement tabNameForSpaceId: aScripter model);
		id: GtWorldTabElement spaceCloseButtonName;
		play.

	^ aScripter
]

{ #category : #'examples - by scripter' }
GtWorldTabElementExamples >> showSpaceSelectScripter_03_clickSpaceCloseButton [
	| aScripter |
	<gtExample>
	
	aScripter := self showSpaceSelectScripter_02_moveMouseOverSpaceCloseButton.
	
	aScripter click
		label: 'Mouse click the close button';
		id: (GtWorldTabElement tabNameForSpaceId: aScripter model);
		id: GtWorldTabElement spaceCloseButtonName;
		play.

	aScripter check
		label: 'Check that there is no more space tab';
		value: [ :theTabGroup | theTabGroup tabs size ] equals: 1;
		onChildFromMessage: #tabs;
		play.

	^ aScripter
]

{ #category : #'examples - by scripter' }
GtWorldTabElementExamples >> showSpaceSelectScripter_04_checkSpaceGarbageCollected [
	| aScripter |
	<gtExample>
	
	aScripter := self showSpaceSelectScripter_03_clickSpaceCloseButton.
	aScripter do
		label: 'Clear scripter events and garbage collect';
		action: [ :_ |
			aScripter events removeAll.
			Smalltalk garbageCollect ];
		play.
	
	aScripter check
		label: 'Check that there is no space with the stored id';
		value: [ :aStepScripter | BlSpace spaceWithId: aStepScripter model do: #yourself ] equals: nil;
		onScripter;
		play.

	^ aScripter
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
