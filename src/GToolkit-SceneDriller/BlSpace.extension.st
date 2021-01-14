Extension { #name : #BlSpace }

{ #category : #'*GToolkit-SceneDriller' }
BlSpace >> withSceneDriller [
	self root addEventFilter: GtSceneDrillerEventHandler new
]
