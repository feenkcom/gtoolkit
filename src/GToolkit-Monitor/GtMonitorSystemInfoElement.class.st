Class {
	#name : #GtMonitorSystemInfoElement,
	#superclass : #BrVerticalPane,
	#category : #'GToolkit-Monitor'
}

{ #category : #'private - elements' }
GtMonitorSystemInfoElement >> buildGlutinEventLoopInfo [
	| anEventLoop |

	self space hasHostSpace
		ifFalse: [ ^ BlElement new size: 0@0 ].

	self class environment
		at: #GlutinEventFetcher
		ifAbsent: [ ^ BlElement new size: 0@0 ].

	anEventLoop := (self class environment at: #GlutinEventFetcher) default eventLoop.

	^ BlElement new
		layout: (BlGridLayout horizontal columnCount: 2; cellSpacing: 10);
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical fitContent ];
		addChildren: {
			BrLabel new
				look: BrGlamorousLabelLook new;
				text: 'System:'.
			BrLabel new
				look: BrGlamorousLabelLook new;
				text: anEventLoop type item }
]

{ #category : #initialization }
GtMonitorSystemInfoElement >> initialize [
	super initialize.

	self matchParent.

	self updateSystemInfo.
	self enqueueTask:
		(BlRepeatedTaskAction new
			delay: 2 seconds;
			action: [ self updateSystemInfo ]).
	self when: BlElementAddedToSceneGraphEvent do: [ self updateSystemInfo ]
]

{ #category : #'private - elements' }
GtMonitorSystemInfoElement >> updateSystemInfo [
	self removeChildren.
	
	self isAttachedToSceneGraph
		ifFalse: [ ^ self ].
		
	self addChildren: { 
		self buildGlutinEventLoopInfo
	}
]
