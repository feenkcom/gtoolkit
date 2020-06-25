Class {
	#name : #GtMonitoredMixedAnnouncer,
	#superclass : #Object,
	#instVars : [
		'announcer'
	],
	#category : #'GToolkit-Monitor-Mixed Announcers'
}

{ #category : #accessing }
GtMonitoredMixedAnnouncer >> announcer [
	<return: #Announcer or: nil>

	^ announcer at: 1
]

{ #category : #accessing }
GtMonitoredMixedAnnouncer >> announcer: anAnnouncer [
	announcer := anAnnouncer asWeakReference
]

{ #category : #testing }
GtMonitoredMixedAnnouncer >> exists [
	^ self announcer isNotNil
]

{ #category : #'gt-extension' }
GtMonitoredMixedAnnouncer >> gtInstVarPointersFor: aView [
	<gtView>
	
	^ aView columnedList
		title: 'Inst.var holders';
		priority: 4;
		items: [ self instVarPointers ];
		column: 'Object' 
			item: [ :eachAssoc | eachAssoc key gtDisplayText ];
		column: 'Class' 
			item: [ :eachAssoc | eachAssoc key class name ];
		column: 'Inst.vars' 
			item: [ :eachAssoc |
				String streamContents: [ :aStream | 
					eachAssoc value
						do: [ :eachName | aStream nextPut: $#; nextPutAll: eachName ]
						separatedBy: [ aStream space ] ] ];
		send: #key
]

{ #category : #'gt-extension' }
GtMonitoredMixedAnnouncer >> gtPathToFor: aView [
	<gtView>
	
	^ aView columnedList
		title: 'Path';
		priority: 11;
		items: [ self pathTo ];
		column: 'Path from Smalltalk' 
			item: [ :anObject | anObject gtDisplayText ]
]

{ #category : #'gt-extension' }
GtMonitoredMixedAnnouncer >> gtPointersFor: aView [
	<gtView>
	
	^ aView columnedList
		title: 'Pointers';
		priority: 10;
		items: [ self pointers ];
		column: 'Pointers' 
			item: [ :anObject | anObject gtDisplayText ]
]

{ #category : #'gt-extension' }
GtMonitoredMixedAnnouncer >> gtSubscriptionsFor: aView [
	<gtView>
	
	^ aView forward
		title: 'Subscriptions';
		priority: 1;
		object: [ self announcer ifNil: [ Announcer new ] ];
		view: #gtSubscriptionsFor:
]

{ #category : #accessing }
GtMonitoredMixedAnnouncer >> instVarPointers [
	| anAnnouncer |
	Smalltalk garbageCollectMost.
	
	anAnnouncer := self announcer.
	anAnnouncer ifNil: [ ^ {  } ].

	^ (self pointers
		select: [ :eachObject |
			(self shouldIgnoreForInstVarsPointer: eachObject) not
				and: [ eachObject instVarsInclude: anAnnouncer ] ]
		thenCollect: [ :eachObject |
			eachObject -> (Array streamContents: [ :aStream |
				| instVarNames |
				instVarNames := eachObject class allInstVarNames.
			
				1 to: instVarNames size
					do: [ :i |
						(eachObject instVarAt: i) == anAnnouncer
							ifTrue: [ aStream nextPut: (instVarNames at: i) ] ] ]) ])
		select: [ :eachAssoc | eachAssoc value isNotEmpty ]
]

{ #category : #accessing }
GtMonitoredMixedAnnouncer >> numberOfStrongSubscriptions [
	^ self announcer
		ifNil: [ 0 ]
		ifNotNil: [ :anAnnouncer |
			(anAnnouncer subscriptions subscriptions
				select: [ :eachSubscription | eachSubscription isKindOf: AnnouncementSubscription ]) size ]
]

{ #category : #accessing }
GtMonitoredMixedAnnouncer >> numberOfSubscriptions [
	^ self announcer
		ifNil: [ 0 ]
		ifNotNil: [ :anAnnouncer | anAnnouncer numberOfSubscriptions ]
]

{ #category : #accessing }
GtMonitoredMixedAnnouncer >> numberOfWeakSubscriptions [
	^ self announcer
		ifNil: [ 0 ]
		ifNotNil: [ :anAnnouncer |
			(anAnnouncer subscriptions subscriptions
				select: [ :eachSubscription | eachSubscription isKindOf: WeakAnnouncementSubscription ]) size ]
]

{ #category : #accessing }
GtMonitoredMixedAnnouncer >> pathTo [
	Smalltalk garbageCollectMost.

	^ self announcer
		ifNil: [ {  } ]
		ifNotNil: [ :anAnnouncer | ReferenceFinder findPathTo: anAnnouncer ]
]

{ #category : #accessing }
GtMonitoredMixedAnnouncer >> pointers [
	Smalltalk garbageCollectMost.

	^ self announcer
		ifNotNil: [ :anAnnouncer | anAnnouncer pointersTo reject: [ :eachObject | eachObject isKindOf: WeakArray ] ]
		ifNil: [ {  } ]
]

{ #category : #private }
GtMonitoredMixedAnnouncer >> shouldIgnoreForInstVarsPointer: anObject [

	(anObject isKindOf: AnnouncementSubscription)
		ifTrue: [ ^ true ].
		
	(anObject isKindOf: WeakAnnouncementSubscription)
		ifTrue: [ ^ true ].
		
	((anObject isKindOf: Context) and: [ anObject method = (Announcer >> #gtSubscriptionsFor:) ])
		ifTrue: [ ^ true ].
	
	((anObject isKindOf: GtPhlowForwarderView) and: [ anObject definingMethod methodClass = self class ])
		ifTrue: [ ^ true ].
		
	(anObject isKindOf: GtPhlowBuildContext)
		ifTrue: [ ^ true ].
		
	^ false
]

{ #category : #accessing }
GtMonitoredMixedAnnouncer >> title [
	^ self announcer
		ifNil: [ '' ]
		ifNotNil: [ :anAnnouncer | anAnnouncer class asString ]
]
