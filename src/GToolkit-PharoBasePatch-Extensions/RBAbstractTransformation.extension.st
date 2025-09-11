Extension { #name : #RBAbstractTransformation }

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
RBAbstractTransformation >> primitiveExecute [
	<gtPharoPatch: #Pharo>
	
	^ self 
		forPharo12AndNewer: [self generateChanges] 
		forPharo11: [Error signal] 
]

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
RBAbstractTransformation >> refactoringError: aString with: aBlock [
	<gtPharoPatch: #Pharo>
	
	^ RBRefactoringError signal: aString with: aBlock
]

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
RBAbstractTransformation >> refactoringFailure: aString [
	<gtPharoPatch: #Pharo>
	
	^ self 
		forPharo12AndNewer: [self refactoringError: aString] 
		forPharo11: [Error signal] 
]
