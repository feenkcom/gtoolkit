Class {
	#name : #GtMonitoredExternalResourceTypeGroup,
	#superclass : #GtMonitoredExternalResourceGroup,
	#instVars : [
		'resourceClass',
		'null',
		'notNull'
	],
	#category : #'GToolkit-Monitor-External Resources'
}

{ #category : #accessing }
GtMonitoredExternalResourceTypeGroup >> children [
	^ { notNull . null }
]

{ #category : #accessing }
GtMonitoredExternalResourceTypeGroup >> name [
	| nullText |

	nullText := ('null: {1}' format: { null size }) asRopedText.
	null size isZero
		ifFalse: [ nullText foreground: BrGlamorousColors linkWithErrorColor ].

	^ ('{1} (total: {2}, valid: {3}, ' format: {
		self resourceClass name.
		null size + notNull size.
		notNull size.
	}) asRopedText, nullText, ')' asRopedText
]

{ #category : #accessing }
GtMonitoredExternalResourceTypeGroup >> resourceClass [
	^ resourceClass
]

{ #category : #accessing }
GtMonitoredExternalResourceTypeGroup >> resourceClass: anObject [
	resourceClass := anObject
]

{ #category : #accessing }
GtMonitoredExternalResourceTypeGroup >> resources: aCollectionOfExternalResources [
	| theGroups |

	theGroups := aCollectionOfExternalResources groupedBy: [ :eachResource | eachResource isNull ].
	
	null := GtMonitoredExternalResourceStatusGroup new isNull: true.
	notNull := GtMonitoredExternalResourceStatusGroup new isNull: false.

	null resources: (theGroups
		at: true
		ifAbsent: [ #() ]).
		
	notNull resources: (theGroups
		at: false
		ifAbsent: [ #() ])
]

{ #category : #accessing }
GtMonitoredExternalResourceTypeGroup >> size [
	^ null size + notNull size
]
