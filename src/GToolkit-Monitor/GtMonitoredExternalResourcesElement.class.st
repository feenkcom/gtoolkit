Class {
	#name : #GtMonitoredExternalResourcesElement,
	#superclass : #BrVerticalPane,
	#instVars : [
		'resourcesTree'
	],
	#category : #'GToolkit-Monitor-External Resources'
}

{ #category : #'instance creation' }
GtMonitoredExternalResourcesElement class >> allExternalResources [
	<script: 'self allExternalResources inspect'>
	| aRegistry allResources|

	aRegistry := FFIExternalResourceManager uniqueInstance instVarNamed: #registry.
	allResources := aRegistry asArray collect: [ :eachResource | GtMonitoredExternalResource new resource: eachResource ].

	^ ((allResources groupedBy: [ :eachResource | eachResource resourceClass ]) associations collect: [ :each |
		GtMonitoredExternalResourceTypeGroup new
			resourceClass: each key;
			resources: each value ]) asSortedCollection: [ :a :b | a size > b size ]
]

{ #category : #'instance creation' }
GtMonitoredExternalResourcesElement class >> open [
	<script: 'self open'>

	GtInspector
		openOn: self new
		title: 'Monitor'
]

{ #category : #initialization }
GtMonitoredExternalResourcesElement >> initialize [
	super initialize.
	
	self matchParent.
	self padding: (BlInsets all: 5).
	
	resourcesTree := BrColumnedTree new.
	resourcesTree addEventHandler: (GtPhlowListToSelectHandler new).

	resourcesTree column
		title: 'Class';
		cellStencil: [ 
			BrLabel new 
				look: BrGlamorousLabelLook new ];
		dataBinder: [  :eachLabel :eachItem | eachLabel text: eachItem name ].

	self addChild: resourcesTree.
	
	self updateList
]

{ #category : #updating }
GtMonitoredExternalResourcesElement >> updateList [
	self
		enqueueTask:
			(BlEnqueuedTaskItAction new
				name: '[Monitor] External resources';
				element: self;
				action: [ self class allExternalResources ];
				onFailureEnqueueAction: [ 'Failed to update External resources list' traceCr ];
				onSuccessEnqueueAction: [ :theExternalResources | 
					resourcesTree
						items: theExternalResources
						lazy: [ :eachItem | eachItem children ] ])
]
