Class {
	#name : #GtReturnPragmasShouldPointToExistingClasses,
	#superclass : #GtLeafConstraint,
	#category : #'GToolkit-Constraints'
}

{ #category : #accessing }
GtReturnPragmasShouldPointToExistingClasses >> description [
	^ 'All references from class comments should be present in the image'
]

{ #category : #accessing }
GtReturnPragmasShouldPointToExistingClasses >> issues [
	| results packages |
	results := GtDocumentMissingReferencesGroup new.
	packages := RPackage organizer packages select: [ :each | 
		each name beginsWith: 'GToolkit' ].
	packages do: [ :aPackage | 
	((aPackage definedClasses select: #hasComment)) do: [ :aClass |
		| visitor missingReferences |
		visitor := GtDocumentMissingReferencesVisitor new.
		missingReferences := visitor missingReferencesInClassCommentFor: aClass.
		missingReferences isNotEmpty ifTrue: [ 
			results addMissingReferences: missingReferences ] ] ].
	^ results
]
