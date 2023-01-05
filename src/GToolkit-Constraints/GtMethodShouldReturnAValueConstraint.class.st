Class {
	#name : #GtMethodShouldReturnAValueConstraint,
	#superclass : #GtPharoConstraint,
	#category : #'GToolkit-Constraints'
}

{ #category : #accessing }
GtMethodShouldReturnAValueConstraint >> issues [
	^ (self targetSelector gtImplementors 
		& '`{:node | node isMethod and: [node body lastIsReturn not]}' gtASTMatches
			select: [ :aMethod | aMethod isAbstract not ]) contents
]

{ #category : #accessing }
GtMethodShouldReturnAValueConstraint >> name [
	^ self targetSelector, ' methods that are not abstract should return a value'
]

{ #category : #accessing }
GtMethodShouldReturnAValueConstraint >> targetSelector [
	self subclassResponsibility
]
