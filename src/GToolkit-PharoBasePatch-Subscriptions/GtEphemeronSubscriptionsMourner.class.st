"
I am the container of one ephemeron of a {{gtClass:GtMixedSubscriptionRegistry}}: the object the ephemeron notifies when it is mourned. When the ephemeron is mourned, {{gtClass:WeakKeyAssociation}} sends me removeKey:ifAbsent:, and I ask the registry to remove exactly my ephemeron, see {{gtMethod:GtMixedSubscriptionRegistry>>#removeEphemeron:}}.
"
Class {
	#name : #GtEphemeronSubscriptionsMourner,
	#superclass : #Object,
	#instVars : [
		'registry',
		'ephemeron'
	],
	#category : #'GToolkit-PharoBasePatch-Subscriptions-Mixed-Core'
}

{ #category : #'instance creation' }
GtEphemeronSubscriptionsMourner class >> registry: aRegistry ephemeron: anEphemeron [
	^self new setRegistry: aRegistry ephemeron: anEphemeron
]

{ #category : #mourning }
GtEphemeronSubscriptionsMourner >> removeKey: aSubscriber ifAbsent: aBlock [
	registry removeEphemeron: ephemeron
]

{ #category : #initialization }
GtEphemeronSubscriptionsMourner >> setRegistry: aRegistry ephemeron: anEphemeron [
	registry := aRegistry.
	ephemeron := anEphemeron
]
