Class {
	#name : 'GtProfilerProcessTelemetriesTool',
	#superclass : 'GtPhlowTool',
	#category : 'GToolkit-Profiler-Process - Tools'
}

{ #category : 'api - converting' }
GtProfilerProcessTelemetriesTool >> asElementDo: aOneArgBlock [
	"Create a tool element and execute the block."
	| aProcessTelemetriesModel aProcessTelemetriesViewModel aProcessTelemetriesElement |
	
	aProcessTelemetriesModel := GtProfilerProcessTelemetriesModel new superProcessTelemetry: BlProcessTelemetry.
	aProcessTelemetriesViewModel := GtProfilerProcessTelemetriesViewModel new
		profilerProcessTelemetriesModel: aProcessTelemetriesModel.
	aProcessTelemetriesElement := GtProfilerProcessTelemetriesElement new
		profilerProcessTelemetriesViewModel: aProcessTelemetriesViewModel.
		
	^ aOneArgBlock value: aProcessTelemetriesElement
]
