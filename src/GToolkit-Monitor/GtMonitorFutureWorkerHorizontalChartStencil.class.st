Class {
	#name : #GtMonitorFutureWorkerHorizontalChartStencil,
	#superclass : #BrStencil,
	#instVars : [
		'executions',
		'startTimeComputation',
		'endTimeComputation',
		'rowLabelComputation',
		'colorComputation',
		'rowValuesComputation',
		'barHeight',
		'rowHeight',
		'hideRowLabels',
		'hideAxisLabels',
		'labelWidth',
		'leftPadding',
		'selectionTransformation'
	],
	#category : #'GToolkit-Monitor-Future Workers'
}

{ #category : #accessing }
GtMonitorFutureWorkerHorizontalChartStencil >> amountOfTicks [
	^ 6
]

{ #category : #accessing }
GtMonitorFutureWorkerHorizontalChartStencil >> barHeight [
	^ barHeight
]

{ #category : #'api - configuration' }
GtMonitorFutureWorkerHorizontalChartStencil >> colorComputation: anObject [

	colorComputation := anObject
]

{ #category : #'api - configuration' }
GtMonitorFutureWorkerHorizontalChartStencil >> configureWithMinimalDetails [
	barHeight := 1.
	rowHeight := 1.
	leftPadding := 20.
	
	hideRowLabels := true.
	hideAxisLabels := false.
]

{ #category : #accessing }
GtMonitorFutureWorkerHorizontalChartStencil >> create [
	<return: #Object>
	| minCreationDate maxExpireDate plot timeScale barWidthScale |
	
	minCreationDate := self firstStartDate.	
	maxExpireDate := self lastEndDate.
	
	timeScale := GtPlotterTimeScale new 
		domainFrom: minCreationDate to: maxExpireDate.
	timeScale tickFormat: [ :eachDateAndTime | 
		(eachDateAndTime - minCreationDate) gtShortPrintString ].
	
	barWidthScale := GtPlotterDurationScale new 
		domainFrom: 0 seconds 
		to: maxExpireDate - minCreationDate.
	
	plot := BrVerticalPane new 
		matchParent.
	
	hideAxisLabels ifFalse: [
		plot addChild: (self 
			createHorizontalThicksLabelsElementForTimeScale: timeScale) ].
	plot addChild: (self
		createPlotterScrollableElementForTimeScale: timeScale 
		andWidthScale: barWidthScale).

	^ plot
]

{ #category : #'private - instance creation' }
GtMonitorFutureWorkerHorizontalChartStencil >> createGridlines: aGtPlotterScale [
	^ GtPlotterHorizontalTicksElement new
		padding: self gridlinePadding;
		preventMeAndChildrenMouseEvents;
		scale: aGtPlotterScale;
		tickStyle: [ :anElement | anElement
			width: self gridlineWidth;
			background: self gridlineColor ];
		ticks: self amountOfTicks
]

{ #category : #'private - instance creation' }
GtMonitorFutureWorkerHorizontalChartStencil >> createHorizontalThicksLabelsElementForTimeScale: aTimeScale [
	^ (GtPlotterHorizontalTickLabelsElement new
		padding: (BlInsets 
			left: self labelWidth + self gridlineOffset + self leftPadding);
		scale: aTimeScale;
		height: 30;
		labels: self amountOfTicks)
]

{ #category : #'private - instance creation' }
GtMonitorFutureWorkerHorizontalChartStencil >> createLabel: aString [
	^ BrLabel new
		aptitude:
			(BrGlamorousLabelAptitude new
				foreground: self labelColor);
		padding: (BlInsets right: 5);
		text: aString
]

{ #category : #'private - instance creation' }
GtMonitorFutureWorkerHorizontalChartStencil >> createLabelCell: aString [
	^ BrVerticalPane new
		matchParent;
		alignCenterRight;
		addChild: (self createLabel: aString);
		hExact: self labelWidth
]

{ #category : #'private - instance creation' }
GtMonitorFutureWorkerHorizontalChartStencil >> createPlotterScrollableElementForTimeScale: timeScale andWidthScale: barWidthScale [
	| scrollableContainer scrollableContent |
	scrollableContainer := BrFrame new 
		matchParent.
	scrollableContent := BrSimpleList new.
	scrollableContent matchParent.
	scrollableContent addEventHandler: (GtPhlowListToSelectHandler new
		transformation: selectionTransformation).
	
	scrollableContent 
		itemStencil: [
			| rowElement |
			rowElement := self createRow.
			hideRowLabels ifFalse: [
				rowElement
					addAptitude: BrGlamorousListItemAptitude new  ].
			rowElement ];
		itemDataBinder: [ :rowContainer  :anExecutionDetails |
			| rowLabel horizontalBars |
			rowContainer removeChildren.
			
			hideRowLabels ifFalse: [
				rowLabel := self createLabelCell: (rowLabelComputation 
					value: anExecutionDetails).
				rowContainer addChild: rowLabel ].
	
			horizontalBars := GtPlotterHorizontalValueBarsElement new
				height: self barHeight;
				valueStyle: [ :anElement :aGtScaleContext |
					self styleBar: anElement execution: aGtScaleContext originalValue.
					anElement constraintsDo: [ :c | 
						c frame horizontal 
							alignLeftAt: (timeScale 
								map: (startTimeComputation 
									value: aGtScaleContext originalValue)) ] ];
				scale: barWidthScale;
				scaleData: [ :each | each duration ];
				values: (rowValuesComputation cull: anExecutionDetails).
		
			rowContainer addChild: horizontalBars. ].
			
	scrollableContent items: self executions.
	
	scrollableContainer addChild: scrollableContent.
	scrollableContainer addChild: (self createGridlines: timeScale). 
	scrollableContainer padding: (BlInsets left: self leftPadding).
	
	^ scrollableContainer
]

{ #category : #'private - instance creation' }
GtMonitorFutureWorkerHorizontalChartStencil >> createRow [
	^ BrHorizontalPane new
		vExact: self rowHeight;
		alignCenter;
		hMatchParent
]

{ #category : #initialization }
GtMonitorFutureWorkerHorizontalChartStencil >> defaultBarColor [
	^ ((Color r: 92 g: 204 b: 231 range: 255) alpha: 0.2)
]

{ #category : #'api - configuration' }
GtMonitorFutureWorkerHorizontalChartStencil >> enabledGroupsInRow [
	rowValuesComputation := [ :anExecution | anExecution items ].
]

{ #category : #'api - configuration' }
GtMonitorFutureWorkerHorizontalChartStencil >> endTimeComputation: anObject [

	endTimeComputation := anObject
]

{ #category : #accessing }
GtMonitorFutureWorkerHorizontalChartStencil >> executions [

	^ executions
]

{ #category : #initialization }
GtMonitorFutureWorkerHorizontalChartStencil >> executions: anObject [

	executions := anObject
]

{ #category : #'private - computation' }
GtMonitorFutureWorkerHorizontalChartStencil >> firstStartDate [
	^ self executions
		inject: (startTimeComputation value: self executions first)
		into: [ :minDate :each | 
			minDate min: (startTimeComputation value: each) ]
]

{ #category : #accessing }
GtMonitorFutureWorkerHorizontalChartStencil >> gridlineColor [
	^ Color gray alpha: 0.2
]

{ #category : #accessing }
GtMonitorFutureWorkerHorizontalChartStencil >> gridlineOffset [
	^ 10
]

{ #category : #accessing }
GtMonitorFutureWorkerHorizontalChartStencil >> gridlinePadding [
	^ BlInsets left: self labelWidth + self gridlineOffset
]

{ #category : #accessing }
GtMonitorFutureWorkerHorizontalChartStencil >> gridlineWidth [
	^ 1
]

{ #category : #initialization }
GtMonitorFutureWorkerHorizontalChartStencil >> initialize [
	super initialize.
	
	barHeight := 15.
	rowHeight := 20.
	labelWidth := 250.
	hideRowLabels := false.
	hideAxisLabels := false.
	leftPadding := 0.
	
	startTimeComputation := [ :anExecution | anExecution startTime ].
	endTimeComputation :=  [ :anExecution | anExecution endTime ].
	rowLabelComputation := [ :anExecution | anExecution label ].
	colorComputation := [ self defaultBarColor ].
	rowValuesComputation := [ :anExecution | {anExecution} ].
	selectionTransformation := [ :each | each ]
]

{ #category : #accessing }
GtMonitorFutureWorkerHorizontalChartStencil >> labelColor [
	^ Color gray
]

{ #category : #accessing }
GtMonitorFutureWorkerHorizontalChartStencil >> labelWidth [
	^ hideRowLabels 
		ifTrue: [ 0 ] 
		ifFalse: [ labelWidth ]
]

{ #category : #'api - configuration' }
GtMonitorFutureWorkerHorizontalChartStencil >> labelWidth: aNumber [
	labelWidth := aNumber
]

{ #category : #'private - computation' }
GtMonitorFutureWorkerHorizontalChartStencil >> lastEndDate [
	^ self executions 
		inject: (endTimeComputation value: self executions  first) 
		into: [ :maxDate :each | 
			maxDate max: (endTimeComputation value: each) ]
]

{ #category : #accessing }
GtMonitorFutureWorkerHorizontalChartStencil >> leftPadding [

	^ leftPadding
]

{ #category : #accessing }
GtMonitorFutureWorkerHorizontalChartStencil >> leftPadding: anObject [

	leftPadding := anObject
]

{ #category : #accessing }
GtMonitorFutureWorkerHorizontalChartStencil >> rowHeight [
	^ rowHeight
]

{ #category : #'api - configuration' }
GtMonitorFutureWorkerHorizontalChartStencil >> rowHeight: aNumber [
	rowHeight := aNumber
]

{ #category : #'api - configuration' }
GtMonitorFutureWorkerHorizontalChartStencil >> rowLabelComputation: anObject [

	rowLabelComputation := anObject
]

{ #category : #'api - configuration' }
GtMonitorFutureWorkerHorizontalChartStencil >> rowValuesComputation: anObject [

	rowValuesComputation := anObject
]

{ #category : #'api - configuration' }
GtMonitorFutureWorkerHorizontalChartStencil >> selectionTransformation: anObject [

	selectionTransformation := anObject
]

{ #category : #'api - configuration' }
GtMonitorFutureWorkerHorizontalChartStencil >> startTimeComputation: anObject [

	startTimeComputation := anObject
]

{ #category : #accessing }
GtMonitorFutureWorkerHorizontalChartStencil >> styleBar: anElement execution: anObject [ 
	^ anElement
		geometry: BlStadium new;
		background: ((colorComputation cull: anObject) ifNil: [
			self defaultBarColor ]) 
]

{ #category : #'api - configuration' }
GtMonitorFutureWorkerHorizontalChartStencil >> withColorBasedOnScheduling [
	self colorComputation: [ :anItem |
					(anItem propertyAt: #correctScheduling ifAbsent: [ false ])
						ifFalse: [ Color red ] 
						ifTrue: [ Color gray ] ]
]

{ #category : #'api - configuration' }
GtMonitorFutureWorkerHorizontalChartStencil >> withDescriptionAsLabel [
	rowLabelComputation := [ :anExecution | anExecution description ]
]

{ #category : #'api - configuration' }
GtMonitorFutureWorkerHorizontalChartStencil >> withDissplayStringAsLabel [
	rowLabelComputation := [ :anExecution | anExecution gtDisplayString ]
]
