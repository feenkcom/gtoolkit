Class {
	#name : #GtTraitsShouldNotBeNested,
	#superclass : #GtPharoConstraint,
	#category : #'GToolkit-Constraints-GToolkit-Constraints'
}

{ #category : #accessing }
GtTraitsShouldNotBeNested >> description [
	^ 'Pharo 8 has issues with nested Traits. For this reason, we should avoid using them in Bloc, Brick or GToolkit packages'
]

{ #category : #accessing }
GtTraitsShouldNotBeNested >> initialize [
	super initialize.
	status := GtNeutralConstraintStatus new
]

{ #category : #accessing }
GtTraitsShouldNotBeNested >> issues [
	^ Smalltalk image allTraits select: [ :eachTrait | 
	eachTrait allTraits isNotEmpty and: [ 
		#('Bloc' . 'Brick' . 'GToolkit' ) anySatisfy: [ :prefix | eachTrait package name beginsWith: prefix ]]].
]

{ #category : #accessing }
GtTraitsShouldNotBeNested >> name [
	^ 'Traits should not be nested'
]
