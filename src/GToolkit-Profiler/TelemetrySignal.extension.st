Extension { #name : #TelemetrySignal }

{ #category : #'*GToolkit-Profiler' }
TelemetrySignal >> gtMapFor: aView [
	<gtView>
	
	^ aView forward
		title: 'Map';
		priority: 0;
		object: [ self task ];
		view: #gtMapFor:
]
