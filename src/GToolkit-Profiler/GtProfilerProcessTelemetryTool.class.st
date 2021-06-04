Class {
	#name : #GtProfilerProcessTelemetryTool,
	#superclass : #GtPhlowTool,
	#traits : 'TGtWithProfilerProcessTelemetryViewModel',
	#classTraits : 'TGtWithProfilerProcessTelemetryViewModel classTrait',
	#category : #'GToolkit-Profiler-Process - Tools'
}

{ #category : #'api - converting' }
GtProfilerProcessTelemetryTool >> asElementDo: aOneArgBlock [
	"Create a tool element and execute the block."
	| aProcessTelemetryElement |

	aProcessTelemetryElement := GtProfilerProcessTelemetryElement	new
		profilerProcessTelemetryViewModel: self profilerProcessTelemetryViewModel.
		
	^ aOneArgBlock value: aProcessTelemetryElement
]
