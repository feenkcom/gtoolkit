Class {
	#name : #GtClassWithCommentsContainingMissingReferences,
	#superclass : #GtPharoConstraint,
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
	| gtProject |
	gtProject := BaselineOfGToolkit gtRlProjectWithRepository: 'github://feenkcom/gtoolkit/src'.
	^ gtProject allPPackages
			reject: [ :aPackage | 
				"To avoid changing class comments in ThreadedFFI"
				aPackage name = 'ThreadedFFI' ]
]

{ #category : #accessing }
GtClassWithCommentsContainingMissingReferences >> status [ 
	^ GtNeutralConstraintStatus new
]
