Class {
	#name : #GtMonitoredExternalResourceStatusGroup,
	#superclass : #GtMonitoredExternalResourceGroup,
	#instVars : [
		'resources',
		'isNull'
	],
	#category : #'GToolkit-Monitor-External Resources'
}

{ #category : #accessing }
GtMonitoredExternalResourceStatusGroup >> children [
	^ self resources
]

{ #category : #accessing }
GtMonitoredExternalResourceStatusGroup >> isNull [
	^ isNull
]

{ #category : #accessing }
GtMonitoredExternalResourceStatusGroup >> isNull: anObject [
	isNull := anObject
]

{ #category : #accessing }
GtMonitoredExternalResourceStatusGroup >> name [
	^ '{1}: {2}' format: { 
		self isNull
			ifTrue: [ 'Null' ]
			ifFalse: [ 'Valid' ].
			
		self resources size
	}
]

{ #category : #accessing }
GtMonitoredExternalResourceStatusGroup >> resources [
	^ resources
]

{ #category : #accessing }
GtMonitoredExternalResourceStatusGroup >> resources: anObject [
	resources := anObject
]

{ #category : #accessing }
GtMonitoredExternalResourceStatusGroup >> size [
	^ self resources size
]
