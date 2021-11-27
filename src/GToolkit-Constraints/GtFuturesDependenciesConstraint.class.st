Class {
	#name : #GtFuturesDependenciesConstraint,
	#superclass : #GtPharoPackageDependenciesConstraint,
	#category : #'GToolkit-Constraints'
}

{ #category : #accessing }
GtFuturesDependenciesConstraint >> issues [
	"returns the facts that contradict the constraint"

	^ self
		package: 'Futures'
		mustDependOn: {
			'Announcements-Core'.
			'Collections-Abstract'.
			'Collections-Sequenceable'.
			'Collections-Stack'.
			'Collections-Streams'.
			'Collections-Unordered'.
			'Kernel'.
			'TaskIt'
		}
]
