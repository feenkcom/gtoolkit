Class {
	#name : #GtAssertionSettings,
	#superclass : #Object,
	#classInstVars : [
		'isAssertionEnabled'
	],
	#category : 'GToolkit-Utility-Assertion'
}

{ #category : #configuration }
GtAssertionSettings class >> disableAssertion [
	isAssertionEnabled := false
]

{ #category : #configuration }
GtAssertionSettings class >> enableAssertion [
	isAssertionEnabled := true
]

{ #category : #initialization }
GtAssertionSettings class >> initialize [
	self enableAssertion
]

{ #category : #accessing }
GtAssertionSettings class >> isAssertionEnabled [
	^ isAssertionEnabled
]
