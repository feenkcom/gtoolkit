Class {
	#name : #GtTelemetryDependenciesConstraint,
	#superclass : #GtPharoPackageDependenciesConstraint,
	#category : #'GToolkit-Constraints'
}

{ #category : #accessing }
GtTelemetryDependenciesConstraint >> issues [
	"returns the facts that contradict the constraint"

	^ self
		package: 'Telemetry'
		mustDependOn: {
			'Announcements-Core'.
			'Beacon-Core'.
			'Collections-Sequenceable'.
			'Collections-Stack'.
			'Kernel'
		}
]
