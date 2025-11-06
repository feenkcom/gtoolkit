Class {
	#name : #GtWeakSubscriptionDisableFinalizationFlag,
	#superclass : #Object,
	#classInstVars : [
		'enabled'
	],
	#category : #'GToolkit-PharoBasePatch-Subscriptions-Core'
}

{ #category : #configuration }
GtWeakSubscriptionDisableFinalizationFlag class >> disable [
	enabled := false
]

{ #category : #configuration }
GtWeakSubscriptionDisableFinalizationFlag class >> enable [
	enabled := true
]

{ #category : #testing }
GtWeakSubscriptionDisableFinalizationFlag class >> isEnabled [
	^ enabled ifNil: [ false ]
]
