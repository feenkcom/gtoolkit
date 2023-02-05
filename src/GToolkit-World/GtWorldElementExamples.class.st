Class {
	#name : #GtWorldElementExamples,
	#superclass : #Object,
	#category : #'GToolkit-World-Examples'
}

{ #category : #accessing }
GtWorldElementExamples >> shortcutsHaveExplicitName [
	<gtExample>
	| worldElement |
	worldElement := GtWorldElement new.
	worldElement shortcuts do: [ :each | self assert: each name notNil ].
	^ worldElement
]

{ #category : #accessing }
GtWorldElementExamples >> takeScreenshotShortcut [
	<gtExample>
	| worldElement shortcut |
	worldElement := GtWorldElement new.
	shortcut := worldElement shortcuts
			detect: [ :each | each name = 'Take screenshot' ]
			ifNone: [ self assert: false description: 'The shortcut should exist' ].
	^ shortcut
]
