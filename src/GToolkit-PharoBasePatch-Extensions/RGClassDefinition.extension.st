Extension { #name : #RGClassDefinition }

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
RGClassDefinition >> category [
	<gtPharoPatch: #Pharo>
	^ self 
		forPharo12: [ 
			self package ifNotNil: [ :aPackage |
				self packageTag 
			  	ifNil: [ aPackage isString 
			  		ifTrue: [ aPackage ]
			  		ifFalse: [ aPackage name ]  ]
			  	ifNotNil: [ :tag | 
			  		({self packageOrganizer 
			  			undefinedPackage undefinedTag name. Package rootTagName} includes: tag) 
			  				ifTrue: [aPackage isString 
			  					ifTrue: [ aPackage ]
			  					ifFalse: [ aPackage name ] ]
			  				ifFalse: [(aPackage isString 
			  					ifTrue: [ aPackage ]
			  					ifFalse: [ aPackage name]) , '-' , tag ] ] ] ] 
		forPharo11AndPharo10: [ category ]
]
