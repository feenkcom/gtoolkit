Class {
	#name : #GtGtoolkitArchitecturalReport,
	#superclass : #GtConstrainerReport,
	#category : #'GToolkit-Constraints'
}

{ #category : #building }
GtGtoolkitArchitecturalReport >> build: aComposite [
	aComposite name: 'GToolkit Architectural Report'.
	aComposite
		addConstraint: GtClassWithCommentsContainingMissingReferences new;
		addConstraint: GtReturnPragmasShouldPointToExistingClasses new
]
