Class {
	#name : #GtRBAcceptVisitorCalledFromNonVisitingMethods,
	#superclass : #GtLeafConstraint,
	#category : #'GToolkit-Constraints'
}

{ #category : #accessing }
GtRBAcceptVisitorCalledFromNonVisitingMethods >> description [
	^ 'There are two interesting methods in the visitor:
- ${method:RBNode>>#acceptVisitor:}$
- ${method:TRBProgramNodeVisitor>>#visitNode:}$

From the outside, we should always use visitNode:.

See *https://github.com/feenkcom/gtoolkit/issues/837*'
]

{ #category : #accessing }
GtRBAcceptVisitorCalledFromNonVisitingMethods >> issues [
	^ (#acceptVisitor: gtReferences select: [:each | 
		"to ignore the reference from this method"
		each method ~= thisContext method and: [ 
			(each selector beginsWith: 'visit') not and: [
				(each methodClass name beginsWith: 'Br') or: [
					(each methodClass name beginsWith: 'Gt') ]]] ]) result
]

{ #category : #accessing }
GtRBAcceptVisitorCalledFromNonVisitingMethods >> name [
	^ 'acceptVisitor: called from non visiting methods'
]
