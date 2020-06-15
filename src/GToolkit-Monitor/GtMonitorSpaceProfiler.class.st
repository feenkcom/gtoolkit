Class {
	#name : #GtMonitorSpaceProfiler,
	#superclass : #BrHorizontalPane,
	#instVars : [
		'openedSpaces'
	],
	#category : #'GToolkit-Monitor-Space Profiler'
}

{ #category : #initialization }
GtMonitorSpaceProfiler >> initialize [
	super initialize.
	
	self matchParent.
	
	openedSpaces := GtMonitorOpenedSpacesElement new.
	openedSpaces width: 300.
	
	self addChild: openedSpaces
]
