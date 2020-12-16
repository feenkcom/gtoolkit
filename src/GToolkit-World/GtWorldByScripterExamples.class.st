Class {
	#name : #GtWorldByScripterExamples,
	#superclass : #Object,
	#traits : 'TBlDevScripterExamples',
	#classTraits : 'TBlDevScripterExamples classTrait',
	#category : #'GToolkit-World-Examples'
}

{ #category : #accessing }
GtWorldByScripterExamples >> spaceWithScripter [
	<gtExample>
	| aWorld aScripter |
	aWorld := BlSpace new 
		title: 'Scripter World';
		host: BlMockedHost new;
		extent: (800*1.6) @ 800.
	aScripter := self scripterWithSpace: aWorld.
	aScripter element: GtWorldElement new.
	aScripter wait forEmptySpaceTaskQueue.
	"50 timesRepeat: [ aScripter wait forEmptySpaceTaskQueue ]."
	^ aScripter syncContinue
]

{ #category : #'examples - world' }
GtWorldByScripterExamples >> world [
	<gtExample>
	| aWorld |
	aWorld := GtWorld new.
	aWorld title: 'Scripter World'.
	aWorld host: BlMockedHost new.
	aWorld extent: (800*1.6) @ 800.
	^ aWorld
]

{ #category : #'examples - world' }
GtWorldByScripterExamples >> worldScripter [
	<gtExample>
	| aScripter |
	aScripter := self scripter.
	aScripter element: GtWorldElement new.
	aScripter wait forEmptySpaceTaskQueue.
	"50 timesRepeat: [ aScripter wait forEmptySpaceTaskQueue ]."
	^ aScripter syncContinue
]
