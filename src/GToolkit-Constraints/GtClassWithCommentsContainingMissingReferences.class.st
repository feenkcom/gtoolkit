Class {
	#name : #GtClassWithCommentsContainingMissingReferences,
	#superclass : #GtLeafConstraint,
	#traits : 'TGtDocumentInvalidCommentsConstraint',
	#classTraits : 'TGtDocumentInvalidCommentsConstraint classTrait',
	#category : #'GToolkit-Constraints'
}

{ #category : #accessing }
GtClassWithCommentsContainingMissingReferences >> description [
	^ 'All references from class comments should be present in the image.'
]

{ #category : #accessing }
GtClassWithCommentsContainingMissingReferences >> name [
	^ 'Classes with comments containing missing references'
]

{ #category : #accessing }
GtClassWithCommentsContainingMissingReferences >> packagesToAnalyse [
	^ RPackage organizer packages select: [ :each | 
		each name beginsWith: 'GToolkit' ]
]
