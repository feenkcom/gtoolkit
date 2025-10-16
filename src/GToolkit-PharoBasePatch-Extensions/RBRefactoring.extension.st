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
RBRefactoring >> onError: aBlock do: errorBlock [
	"Pharo 12 has fixed this so it can be removed when Pharo 11 is no longer used."

	<gtPharoPatch: #Pharo11>
	^ aBlock
		on: self class preconditionSignal
		do: [ :ex | 
			errorBlock cull: ex.
			ex return: nil ]
]

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
RBRefactoring >> performCompositeRefactoring: aRefactoring [
	<gtPharoPatch: #Pharo12>
	
	aRefactoring copyOptionsFrom: self options.
	aRefactoring primitiveExecute
]

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
RBRefactoring >> trueCondition [
	<gtPharoPatch:  #Pharo12>
	"We add it here so we can use it in Pharo 11"
	^ RBCondition true
]
