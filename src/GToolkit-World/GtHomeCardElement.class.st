Class {
	#name : #GtHomeCardElement,
	#superclass : #BlElement,
	#traits : 'TBrLayoutResizable',
	#classTraits : 'TBrLayoutResizable classTrait',
	#category : #'GToolkit-World-Sections'
}

{ #category : #initialization }
GtHomeCardElement >> defaultLayout [
	^ BlLinearLayout vertical
]

{ #category : #initialization }
GtHomeCardElement >> initialize [
	super initialize.
	
	self exact: 150@200.
]
