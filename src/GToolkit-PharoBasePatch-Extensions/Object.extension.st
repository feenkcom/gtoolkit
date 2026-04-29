Extension { #name : #Object }

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
Object >> isPharoPackageModel [
	^ false
]

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
Object >> isPharoPackageTagModel [
	^ false
]

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
Object >> isPharoRefactoringModel [
	^ self 
			forPharo13AndNewer: [ self isKindOf: ReRefactoring ] 
			forOlder: [ self isKindOf: RBRefactoring ]
]

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
Object >> packageOrganizer [
	<gtPharoPatch: #Pharo12>
	
	^ self class packageOrganizer
]
