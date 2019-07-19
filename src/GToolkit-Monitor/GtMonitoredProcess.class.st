Class {
	#name : #GtMonitoredProcess,
	#superclass : #GtMonitoredService,
	#category : #'GToolkit-Monitor'
}

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
GtMonitoredProcess >> title [
	<return: #String>
	^ self service ifNotNil: [ :aService | aService gtName ] ifNil: [ '' ]
]
