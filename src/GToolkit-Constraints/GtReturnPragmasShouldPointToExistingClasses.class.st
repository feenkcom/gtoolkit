Class {
	#name : #GtReturnPragmasShouldPointToExistingClasses,
	#superclass : #GtLeafConstraint,
	#category : #'GToolkit-Constraints'
}

{ #category : #accessing }
GtReturnPragmasShouldPointToExistingClasses >> description [
	^ 'The type defined in ==<return: #AType>== must exist in the image.'
]

{ #category : #accessing }
GtReturnPragmasShouldPointToExistingClasses >> issues [
	^ #return: gtPragmas & 
		(RBParser parseRewriteMethod: '
		    a 
		        <return: `{:node | 
		            node isLiteralNode and: [
		                | name |
		                name := node value.
		                (name indexOfSubCollection: '' class'') > 0 ifTrue: [name := name copyFrom: 1 to: name size - 6].
		                (Smalltalk includesKey: name asSymbol) not]}>') pragmas first gtASTMatches
]
