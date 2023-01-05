Class {
	#name : #GtClassesImplementingEqualsShouldAlsoHaveHashConstraint,
	#superclass : #GtPharoConstraint,
	#category : #'GToolkit-Constraints'
}

{ #category : #accessing }
GtClassesImplementingEqualsShouldAlsoHaveHashConstraint >> gtViewByPackageFor: aView [ 
	<gtView>

	^ aView columnedList 
		title: 'By Package';
		items: [  
			(self issues 
				groupedBy: [ :aMethod | aMethod package ]) associations 
				sorted: [ :assoc | assoc value size ] descending ];
		column: 'Package' text: [ :assoc | assoc key ];
		column: 'Count' text: [ :assoc | assoc value size ];
		send: [ :assoc | assoc value ]
]

{ #category : #accessing }
GtClassesImplementingEqualsShouldAlsoHaveHashConstraint >> gtViewByPackageInGTFor: aView [ 
	<gtView>

	^ aView columnedList 
		title: 'By Package (in GT)';
		items: [  
			| gtPackages |
			gtPackages := BaselineOfGToolkit gtRlAllValidRPackages.
			((self issues 
				groupedBy: [ :aMethod | aMethod package ]) associations 
				select: [ :assoc | gtPackages includes: assoc key ])
				sorted: [ :assoc | assoc value size ] descending ];
		column: 'Package' text: [ :assoc | assoc key ];
		column: 'Count' text: [ :assoc | assoc value size ];
		send: [ :assoc | assoc value ]
]

{ #category : #accessing }
GtClassesImplementingEqualsShouldAlsoHaveHashConstraint >> issues [
	| equalsImplementors |
	equalsImplementors := #= gtImplementors contents.
	
	^ equalsImplementors reject: [ :aMethod |
		aMethod methodClass includesSelector: #hash ].
]

{ #category : #accessing }
GtClassesImplementingEqualsShouldAlsoHaveHashConstraint >> name [
	^ 'Classes implementing = should also implement hash.'
]

{ #category : #accessing }
GtClassesImplementingEqualsShouldAlsoHaveHashConstraint >> status [ 
	^ GtNeutralConstraintStatus new
]
