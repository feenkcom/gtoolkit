Extension { #name : #Behavior }

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
Behavior >> isPharoRefactoringModelClass [
	^ self 
			forPharo13AndNewer: [ self inheritsFrom:  ReRefactoring ] 
			forOlder: [ self inheritsFrom: RBRefactoring ]
]
