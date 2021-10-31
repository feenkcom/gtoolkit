Class {
	#name : #GtClassWithCommentsContainingMissingReferences,
	#superclass : #GtPharoConstraint,
	#traits : 'TLeInvalidCommentsConstraint',
	#classTraits : 'TLeInvalidCommentsConstraint classTrait',
	#category : #'GToolkit-Constraints'
}

{ #category : #accessing }
GtClassWithCommentsContainingMissingReferences >> description [
	^ 'All references from class comments should be present in the image.'
]

{ #category : #accessing }
GtClassWithCommentsContainingMissingReferences >> gtViewReferencesFor: aView [ 
	<gtView>
	^ aView forward 
		title: 'Missing references by page';
		priority: 20;
		object: [ self issues ];
		view: #gtViewReferencesFor:
]

{ #category : #accessing }
GtClassWithCommentsContainingMissingReferences >> name [
	^ 'Classes with comments containing missing references'
]

{ #category : #accessing }
GtClassWithCommentsContainingMissingReferences >> packagesToAnalyse [
	| gtProject allPackages |
	gtProject := BaselineOfGToolkit gtRlProjectWithRepository: 'github://feenkcom/gtoolkit:main/src'.
	allPackages := gtProject allPPackages.
	^ allPackages reject: [ :aPackage | aPackage isNil ]
]
