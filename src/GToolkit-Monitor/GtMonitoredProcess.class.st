Class {
	#name : #GtMonitoredProcess,
	#superclass : #GtMonitoredService,
	#category : #'GToolkit-Monitor'
}

{ #category : #accessing }
GtMonitoredProcess >> annotations [
	<return: #Array of: #Association>
	| aService |
	aService := self service.
	aService ifNil: [ ^ #() ].
	aService hasProcessAnnotations ifFalse: [ ^ #() ].
	^ Array streamContents: [ :aStream |
		aService processAnnotation associationsDo: [ :eachAssoc | 
			aStream nextPut: eachAssoc ] ]
]

{ #category : #'gt-extension' }
GtMonitoredProcess >> gtAnnotationsFor: aView [
	<gtView>
	self annotations ifEmpty: [ ^ aView empty ].
	^ aView columnedList
		title: 'Annotations';
		priority: 10;
		items: [ self annotations ];
		column: 'Name' item: [ :anAssoc | anAssoc key ];
		column: 'Value' item: [ :anAssoc | anAssoc value ];
		send: [ :anAssoc | anAssoc value ]
		
]

{ #category : #'gt-extension' }
GtMonitoredProcess >> gtStackFor: aView [
	<gtView>
	^ aView explicit
		title: 'Stack';
		priority: 1;
		stencil: [ GtMethodsCoder forItems: self stack ]
]

{ #category : #'gt-extension' }
GtMonitoredProcess >> gtUpdatingStackFor: aView [
	<gtView>
	^ aView explicit
		title: 'Updating Stack';
		priority: 2;
		stencil: [ GtMonitoredProcessElement new service: self ]
]

{ #category : #testing }
GtMonitoredProcess >> isSuspended [
	<return: #Boolean>
	^ self service ifNotNil: [ :aService | aService isSuspended ] ifNil: [ false ]
]

{ #category : #accessing }
GtMonitoredProcess >> priority [
	<return: #Integer>
	^ self service ifNotNil: [ :aService | aService priority ] ifNil: [ 0 ]
]

{ #category : #accessing }
GtMonitoredProcess >> processIdAndContext [
	<return: #String>
	^ self service ifNotNil: [ :aProcess | 
			aProcess name, ': ', aProcess suspendedContext asString ]
]

{ #category : #accessing }
GtMonitoredProcess >> stack [
	<return: #Array or: #Context>
	^ self stackOfSize: 20
]

{ #category : #accessing }
GtMonitoredProcess >> stackOfSize: aStackDepth [
	<return: #Array or: #Context>
	| aProcess |
	aProcess := self service.
	aProcess ifNil: [ ^ #() ].
	^ aProcess == Processor activeProcess
		ifTrue: [ thisContext stackOfSize: aStackDepth ]
		ifFalse: [ aProcess suspendedContext stackOfSize: aStackDepth ]
]

{ #category : #accessing }
GtMonitoredProcess >> suspendedContext [
	<return: #Context or: nil>
	^ self service ifNotNil: [ :aService | aService suspendedContext ]
]

{ #category : #accessing }
GtMonitoredProcess >> title [
	<return: #String>
	^ self service ifNotNil: [ :aService | aService gtName ] ifNil: [ '' ]
]
