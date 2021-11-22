"
Use {{gtClass:BrElementUpdater}} instead.
"
Class {
	#name : #GtPhlowUpdateRequester,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'element',
		'mutex',
		'isUpdateRequested',
		'action',
		'postponedDuration'
	],
	#category : #'GToolkit-Notifications-Basic'
}

{ #category : #testing }
GtPhlowUpdateRequester class >> isDeprecated [

	"Use BrElementUpdater instead"

	^ true
]
