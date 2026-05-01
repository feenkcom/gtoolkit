Extension { #name : #RGBehaviorDefinition }

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
RGBehaviorDefinition >> category [
	<gtPharoPatch: #Pharo>
	^ self package ifNotNil: [ :aPackage |
		  self packageTag
			  ifNil: [ aPackage name ]
			  ifNotNil: [ :tag | aPackage name , '-' , tag ] ]
]
