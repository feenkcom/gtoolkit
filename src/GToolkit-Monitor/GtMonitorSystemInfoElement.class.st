Class {
	#name : #GtMonitorSystemInfoElement,
	#superclass : #BrVerticalPane,
	#instVars : [
		'infos'
	],
	#category : #'GToolkit-Monitor-System Info'
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

	^ self buildSectionContainer
		addChild: (self buildSectionLabelNamed: 'System');
		addChild: (self
			buildPropertyButtonNamed: anEventLoop type item
			spawn: [ self phlow spawnObject: anEventLoop ])
]

{ #category : #'private - instance creation' }
GtMonitorSystemInfoElement >> buildPropertyButtonNamed: aName spawn: aSpawnBlock [
	^ BrButton new
		beSmallSize;
		background: BrGlamorousColors neutralBackgroundColor;
		look: BrGlamorousButtonRectangularLook + BrGlamorousButtonLabelLook;
		label: aName;
		hMatchParent;
		action: aSpawnBlock
]

{ #category : #'private - instance creation' }
GtMonitorSystemInfoElement >> buildSectionContainer [
	^ BrVerticalPane new
		hMatchParent;
		vFitContent;
		cellSpacing: 5
]

{ #category : #'private - instance creation' }
GtMonitorSystemInfoElement >> buildSectionLabelNamed: aString [
	^ BrLabel new
		look: (BrGlamorousLabelLook new foreground: Color gray; fontSize: 12);
		hMatchParent;
		text: aString
]

{ #category : #'private - elements' }
GtMonitorSystemInfoElement >> buildSkiaCompositorsInfo [
	| allSkiaCompositors |

	self class environment
		at: #SkiaCompositor
		ifAbsent: [ ^ BlElement new size: 0@0 ].

	allSkiaCompositors := SkiaCompositor allInstances.

	^ self buildSectionContainer
		addChild: (self buildSectionLabelNamed: 'Skia Compositors');
		addChildren: (allSkiaCompositors collect: [ :eachCompositor |
			| aShortDescription |
			
			aShortDescription := String streamContents: [ :aStream |
				aStream
					nextPutAll: 'cached images: ';
					print: eachCompositor cachedImagesCount;
					nextPutAll: ' shadows: ';
					print: eachCompositor cachedShadowsCount ].
			
			self
				buildPropertyButtonNamed: aShortDescription
				spawn: [ self phlow spawnObject: eachCompositor ] ])
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
GtMonitorSystemInfoElement >> initializeSystemInfo [
	infos removeChildren.
	
	infos addChild: self buildGlutinEventLoopInfo.
	infos addChild: self buildSkiaCompositorsInfo.
]

{ #category : #'private - elements' }
GtMonitorSystemInfoElement >> updateSystemInfo [
	self removeChildren.
	
	self isAttachedToSceneGraph
		ifFalse: [ ^ self ].

	self addChild: (infos := BlElement new
		layout: (BlGridLayout horizontal columnCount: 2; cellSpacing: 8);
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical fitContent ]) asScrollableElement.
		
	self initializeSystemInfo
]
