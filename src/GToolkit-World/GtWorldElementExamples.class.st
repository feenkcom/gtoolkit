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
	worldElement shortcuts do: [ :each | self assert: each name notNil ]
]
