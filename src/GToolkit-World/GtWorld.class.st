Class {
	#name : #GtWorld,
	#superclass : #BlSpace,
	#instVars : [
		'spotterDropdown',
		'subSpaceDropdown'
	],
	#category : #'GToolkit-World'
}

{ #category : #'instance creation' }
GtWorld class >> open [
	<script: 'self open'>
	| aSpace |
	
	aSpace := GtWorld new.
	aSpace title: 'Glamorous Toolkit'.
	aSpace fullsize: true.
	aSpace show
]

{ #category : #'instance creation' }
GtWorld class >> openWithShutdownListener [
	<script: 'self openWithShutdownListener'>
	| aSpace |
	
	aSpace := GtWorld new.
	aSpace title: 'Glamorous Toolkit'.
	aSpace fullsize: true.
	aSpace addEventHandler: BlSpaceShutdownOnCloseListener new.
	aSpace show.
]

{ #category : #initialization }
GtWorld >> defaultRoot [
	^ GtWorldElement new
]
