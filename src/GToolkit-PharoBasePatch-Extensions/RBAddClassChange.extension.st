Extension { #name : #RBAddClassChange }

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
RBAddClassChange >> definition [
	<gtPharoPatch: #Pharo12>
	^ self 
		forPharo12: [ self definitionPharo12OldFormat ] 
		forPharo11AndPharo10: [ super definition ]
]

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
RBAddClassChange >> definitionPharo12OldFormat [
	<gtPharoPatch: #Pharo12>
	^ '<1s> subclass: #<2s> instanceVariableNames: ''<3s>'' classVariableNames: ''<4s>'' poolDictionaries: ''<5s>'' category: <6p>'
		expandMacrosWithArguments: (Array 
			with: builder superclassName
			with: builder name
			with: (String streamContents: [ :s | 
				self instanceVariableNames asStringOn: s delimiter: ' ' ] )
			with: (String streamContents: [ :s | 
				self classVariableNames asStringOn: s delimiter: ' ' ] )
			with: (String streamContents: [ :s | 
				self sharedPoolNames asStringOn: s delimiter: ' ' ] )
			with: (builder tag
		 	 ifNotNil: [ :packageTag | builder package , '-' , packageTag ]
		 	 ifNil: [ builder package ]) asString)
]
