Class {
	#name : #GtMonitoredScripterPulsersElement,
	#superclass : #BlElement,
	#instVars : [
		'pulserList'
	],
	#category : #'GToolkit-Monitor-Scripter'
}

{ #category : #accessing }
GtMonitoredScripterPulsersElement class >> allScripterPulsers [
	^ BlDevScripterPulseUntilReady allSubInstances 
		collect: [ :anInstance |
			GtMonitoredScripterPulser new pulser: anInstance ]
]

{ #category : #initialization }
GtMonitoredScripterPulsersElement >> initialize [
	super initialize.
	
	self constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
		
	pulserList := BrColumnedList new.
	pulserList addEventHandler: (GtPhlowListToSelectHandler new).
	pulserList rowStencil: (BrGlamorousColumnedListSelectableRowElementStencilBuilder new
		cellSpacing: 10;
		padding: (BlInsets top: 4 bottom: 4)).
		
	pulserList column
		title: 'Method';
		stencil: [ :aMonitoredPulser |
			| aTitle |
			
			aTitle := aMonitoredPulser title
				ifEmpty: [ '~Garbage collected~' asRopedText italic foreground: Color gray ].
			
			BrLabel new
				aptitude: BrGlamorousLabelAptitude;
				text: aTitle;
				hMatchParent ].
				
	pulserList column
		title: 'Status';
		stencil: [ :aMonitoredPulser |
			| aTitle |
			
			aTitle := aMonitoredPulser status
				ifEmpty: [ '~Garbage collected~' asRopedText italic foreground: Color gray ].
			
			BrLabel new
				aptitude: BrGlamorousLabelAptitude;
				text: aTitle;
				hMatchParent ].
				
	self addChild: pulserList.
	
	self updateList
]

{ #category : #updating }
GtMonitoredScripterPulsersElement >> updateList [
	pulserList items: self class allScripterPulsers
]
