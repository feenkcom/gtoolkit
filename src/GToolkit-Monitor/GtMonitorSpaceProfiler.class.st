Class {
	#name : #GtMonitorSpaceProfiler,
	#superclass : #BrPager,
	#instVars : [
		'openedSpaces',
		'framesChart'
	],
	#category : #'GToolkit-Monitor-Space Profiler'
}

{ #category : #initialization }
GtMonitorSpaceProfiler >> initialize [
	super initialize.
	
	self matchParent.
	self look: BrProportionalPagerLook new.
	
	openedSpaces := GtMonitorOpenedSpacesElement new.
	framesChart := GtMonitorSpaceFramesChart new.
	
	self addPage: (BlElement new
		viewModel: BrPagerPageModel new;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		addChild: openedSpaces).
		
		
	self addPage: (BlElement new
		viewModel: BrPagerPageModel new;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		addChild: framesChart).
	
	self
		when: GtPhlowObjectToSpawn
		do: [ :anEvent |
			(anEvent object isKindOf: GtMonitorOpenedSpace)
				ifTrue: [
					anEvent consumed: true.
					framesChart profileSpace: anEvent object ] ].
	
	self
		when: GtPhlowObjectToSelect
		do: [ :anEvent |
			(anEvent object isKindOf: GtMonitorOpenedSpace)
				ifTrue: [
					anEvent consumed: true.
					framesChart profileSpace: anEvent object ] ]
]
