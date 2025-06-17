Extension { #name : #RBRefactoring }

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
RBRefactoring >> model [
	<gtPharoPatch:  #Pharo12>
	
	^ self
		forPharo12: [ 
			model
				ifNil: [ model := (GtRBNamespace onEnvironment: self defaultEnvironment)
							name: 'Changes for ' , self class name asString;
							yourself ]
				ifNotNil: [ model ] ]
		forPharo11AndPharo10: [ 
			model
				ifNil: [ model := (RBClassModelFactory rbNamespace
							onEnvironment: self defaultEnvironment)
							name: self printString;
							yourself ]
				ifNotNil: [ model ] ]
]

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
RBRefactoring >> performCompositeRefactoring: aRefactoring [
	<gtPharoPatch: #Pharo12>
	
	aRefactoring copyOptionsFrom: self options.
	aRefactoring primitiveExecute
]

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
RBRefactoring >> privateTransform [
	<gtPharoPatch: #Pharo12>
	
	self transform
]

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
RBRefactoring >> transform [
	<gtPharoPatch: #Pharo12>
	^ self subclassResponsibility
]
