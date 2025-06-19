Extension { #name : #RBRefactoring }

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
RBRefactoring >> model [
	<gtPharoPatch:  #Pharo12>
	
	^ model
		ifNil: [ 
			model := (Smalltalk createRbNamespace
				onEnvironment: self defaultEnvironment)
				name: self printString;
				yourself ]
		ifNotNil: [ model ]
]

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
RBRefactoring >> performCompositeRefactoring: aRefactoring [
	<gtPharoPatch: #Pharo12>
	
	aRefactoring copyOptionsFrom: self options.
	aRefactoring primitiveExecute
]
