"
Architectural report for Glamorous Toolkit.
"
Class {
	#name : #GtGtoolkitArchitecturalReport,
	#superclass : #GtConstrainerReport,
	#category : #'GToolkit-Constraints'
}

{ #category : #accessing }
GtGtoolkitArchitecturalReport class >> yourself [
	<gtExample>
	^ self new
]

{ #category : #building }
GtGtoolkitArchitecturalReport >> build: aComposite [
	aComposite name: 'GToolkit Architectural Report'.
	aComposite
		addConstraint: GtClassWithCommentsContainingMissingReferences new;
		addConstraint: GtReturnPragmasShouldPointToExistingClasses new;
		addConstraint: GtRBAcceptVisitorCalledFromNonVisitingMethods  new;
		addConstraint: GtButtonsDefiningActionsThroughModels new;
		addConstraint: GtLooksSubscribingToEventsNotFromInitializeListenerMethods new;
		addConstraint: GtBlocEventsShouldHaveDispatchMethodSimilarToClass new;
		addConstraint: GtSubscriptionsShouldNotUseDeliveryConditionWhere new;
		addConstraint: GtTraitsShouldNotBeNested new;
		addConstraint: GtWeakSubscriptionsWithBlockSubscribers new;
		addConstraint: GtBaselinesShouldProperlySpecifyDependencies new
]
