Extension { #name : #TelemetryPing }

{ #category : #'*GToolkit-Profiler' }
TelemetryPing >> gtBarElements [
	^ (self gtBarElementsWithGlobalWeight: 1.0 local: 1.0) asScrollableElement
		margin: (BlInsets all: 10)
]

{ #category : #'*GToolkit-Profiler' }
TelemetryPing >> gtBarElementsWithGlobalWeight: aWeight local: aLocalWeight [
	| taskElements aBarColor |
	
	aBarColor := BlColorTransition interpolate: Color veryLightGray to: BrGlamorousColors errorBorderColor at: aWeight.
	
	taskElements := aWeight > 0.1
		ifTrue: [
			| myDuration |		
			myDuration := self duration.
	
			self tasks collect: [ :eachTask |
				| eachWeight |
				
				eachWeight := myDuration isZero
					ifTrue: [ 0 ]
					ifFalse: [ (eachTask duration / myDuration) asFloat ].
				(eachTask gtBarElementsWithGlobalWeight: eachWeight * aWeight local: eachWeight)
					constraintsDo: [ :c | c linear weight: (eachWeight max: 0.001) ] ] ]
		ifFalse: [
			self tasks
				ifEmpty: [ #() ]
				ifNotEmpty: [ {
					BlElement new
						layout: BlLinearLayout horizontal;
						constraintsDo: [ :c |
							c horizontal matchParent.
							c vertical exact: 20 ];
						when: BlClickEvent
						do: [ :anEvent |
							anEvent consumed: true.
							anEvent currentTarget phlow spawnObject: self ];
						geometry: (BlRoundedRectangleGeometry cornerRadius: 3);
						border: (BlBorder paint: Color transparent width: (aWeight max: 0.1));
						background: (BlLinearGradientPaint vertical stops: {
							0 -> aBarColor.
							0.4 -> (aBarColor alpha: 0.5).
							1 -> (aBarColor alpha: 0)}) } ] ].
	
	^ BlElement new
		layout: BlLinearLayout vertical;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical fitContent ];
		addChild: (BlElement new
			layout: BlLinearLayout horizontal alignCenter;
			when: BlClickEvent
			do: [ :anEvent |
				anEvent consumed: true.
				anEvent currentTarget phlow spawnObject: self ];
			constraintsDo: [ :c |
				c horizontal matchParent.
				c vertical exact: 20 ];
			padding: (BlInsets top: 3 bottom: 3);
			geometry: (BlRoundedRectangleGeometry cornerRadius: 3);
			border: (BlBorder paint: Color transparent width: 0.25);
			background: aBarColor;
			in: [ :aPane | aWeight > 0.005
				ifTrue: [ aPane addChild: (BrLabel new
					aptitude: (BrGlamorousLabelAptitude new fontSize: 10);
					text: self printString) asScalableElement ] ];
			yourself);
		addChild: (BlElement new
			layout: (BlLinearLayout horizontal alignTopCenter weightSum: 1);
			constraintsDo: [ :c |
				c horizontal matchParent.
				c vertical fitContent ];
			addChildren: taskElements);
		yourself
]

{ #category : #'*GToolkit-Profiler' }
TelemetryPing >> gtMapFor: aView [
	<gtView>

	^ aView explicit
		title: 'Map';
		priority: 1;
		stencil: [ self gtBarElements ]
]

{ #category : #'*GToolkit-Profiler' }
TelemetryPing >> gtNestedTree [
	^ self tasks
		ifEmpty: [
			GtNestedTreeNode new
				name: self name;
				leaves: {
					GtNestedTreeItemLeaf new 
					item: self;
					weight: [ :aTask | aTask durationInMilliseconds ] } ]
		ifNotEmpty: [ :theTasks |
			GtNestedTreeNode new 
				name: self name;
				nodes: (theTasks collect: [ :eachTask | eachTask gtNestedTree ] as: Array) ]
]

{ #category : #'*GToolkit-Profiler' }
TelemetryPing >> gtSourceFor: aView [
	<gtView>
	^ aView forward
		title: 'Source';
		priority: 2;
		object: [ sender ];
		view: #gtSourceFor:
]

{ #category : #'*GToolkit-Profiler' }
TelemetryPing >> gtTreeFor: aView [
	<gtView>
	
	^ aView forward
		title: 'Tree';
		priority: 3;
		object: [ self gtNestedTree ];
		view: #gtTreeFor:
]
