Class {
	#name : #GtMonitoredMixedAnnouncersElement,
	#superclass : #BlElement,
	#instVars : [
		'announcersList'
	],
	#category : #'GToolkit-Monitor-Mixed Announcers'
}

{ #category : #private }
GtMonitoredMixedAnnouncersElement class >> allMixedAnnouncers [
	| allMixedAnnouncers |
	
	allMixedAnnouncers := Announcer allSubInstances select: [ :eachAnnouncer |
		(eachAnnouncer subscriptions subscriptions groupedBy: [ :each | each class ]) keys size > 1 ].
	allMixedAnnouncers := allMixedAnnouncers sorted: [ :a :b | a numberOfSubscriptions > b numberOfSubscriptions ].

	allMixedAnnouncers := allMixedAnnouncers
		collect: [ :eachAnnouncer | GtMonitoredMixedAnnouncer new announcer: eachAnnouncer ].
	
	^ allMixedAnnouncers
]

{ #category : #'instance creation' }
GtMonitoredMixedAnnouncersElement class >> open [
	<script: 'self open'>
	GtInspector openOn: self new title: 'Monitor'
]

{ #category : #initialization }
GtMonitoredMixedAnnouncersElement >> initialize [
	super initialize.
	
	self constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	
	announcersList := BrColumnedList new.
	announcersList addEventHandler: (GtInspectorListToSelectHandler new).
	announcersList rowStencil: (BrListClickableRowStencilBuilder new
		cellSpacing: 10;
		padding: (BlInsets top: 4 bottom: 4)).

	announcersList column
		title: 'Announcer';
		stencil: [ :aMonitoredAnnouncer |
			| aTitle |
			
			aTitle := aMonitoredAnnouncer title
				ifEmpty: [ '~Garbage collected~' asRopedText italic foreground: Color gray ].
			
			BrLabel new
				look: BrGlamorousLabelLook;
				text: aTitle;
				hMatchParent ].

	announcersList column
		title: 'Subscriptions';
		stencil: [ :aMonitoredAnnouncer |
			BrLabel new
				look: BrGlamorousLabelLook;
				text: (aMonitoredAnnouncer numberOfSubscriptions asRopedText bold
					append: (' (strong: {1}; weak: {2})' format: {
						aMonitoredAnnouncer numberOfStrongSubscriptions.
						aMonitoredAnnouncer numberOfWeakSubscriptions
					}) asRopedText);
				hMatchParent ].
		
	self addChild: announcersList.
	
	self updateList
]

{ #category : #updating }
GtMonitoredMixedAnnouncersElement >> updateList [
	announcersList items: self class allMixedAnnouncers
]
