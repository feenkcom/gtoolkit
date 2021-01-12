Class {
	#name : #GtSceneDrillerEventHandler,
	#superclass : #BlCustomEventHandler,
	#classVars : [
		'HaloUserDataKey'
	],
	#category : #'GToolkit-SceneDriller'
}

{ #category : #'class initialization' }
GtSceneDrillerEventHandler class >> initialize [
	HaloUserDataKey := #'gtoolkit-halo'
]

{ #category : #'api - accessing' }
GtSceneDrillerEventHandler >> eventsToHandle [
	^ { GtSceneDrillerShowWish . GtSceneDrillerHideWish }
]

{ #category : #'event handling' }
GtSceneDrillerEventHandler >> hideHalo: aHideHaloEvent [
	| aTargetElement |

	aTargetElement := aHideHaloEvent currentTarget.
	(aTargetElement userData
		at: HaloUserDataKey
		ifAbsent: [ false ])
			ifFalse: [ ^ self ].

	aTargetElement userData
		at: HaloUserDataKey
		put: false.

	aTargetElement
		childWithId: #sceneDriller
		ifFound: [ :aSceneDriller |
			| aTargetElementChildren |
			aTargetElementChildren := aSceneDriller targetContainer children asArray.
			aSceneDriller targetContainer removeChildren.
			aTargetElement removeChildren.
			aTargetElement addChildren: aTargetElementChildren ]
		ifNone: [ ^ self ]
]

{ #category : #'event handling' }
GtSceneDrillerEventHandler >> showHalo: aShowHaloEvent [
	| aTargetElement aTargetElementChildren aTargetContainer |

	aShowHaloEvent consumed: true.
	
	aTargetElement := aShowHaloEvent currentTarget.
	(aTargetElement userData
		at: HaloUserDataKey
		ifAbsent: [ false ])
			ifTrue: [ ^ self ].
			
	aTargetElement userData
		at: HaloUserDataKey
		put: true.

	aTargetElementChildren := aTargetElement children asArray.
	aTargetElement removeChildren.

	aTargetContainer := BlElement new.
	aTargetContainer constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	
	aTargetContainer addChildren: aTargetElementChildren.
	
	aTargetElement addChild: (GtSceneDriller new initializeWith: aTargetContainer) as: #sceneDriller
]
