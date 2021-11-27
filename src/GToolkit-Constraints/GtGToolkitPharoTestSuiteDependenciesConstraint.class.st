Class {
	#name : #GtGToolkitPharoTestSuiteDependenciesConstraint,
	#superclass : #GtPharoPackageDependenciesConstraint,
	#category : #'GToolkit-Constraints'
}

{ #category : #accessing }
GtGToolkitPharoTestSuiteDependenciesConstraint >> issues [
	"returns the facts that contradict the constraint"

	^ self
		package: 'GToolkit-Pharo-TestSuite'
		mustDependOn: {
			'Announcements-Core'.
			'Collections-Sequenceable'.
			'Collections-Unordered'.
			'Futures'.
			'GToolkit-Pharo-Coder'.
			'Kernel'.
			'SUnit-Core'
		}
]
