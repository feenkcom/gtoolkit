baseline
baseline: spec
	<baseline>
	spec for: #common do: [ 
		spec
			baseline: 'GToolkitDocumenter' with: [ spec repository: 'github://feenkcom/gtoolkit-documenter/src' ];
			baseline: 'GToolkitTranscript' with: [ spec repository: 'github://feenkcom/gtoolkit/src' ];
			baseline: 'GToolkitVisualizerPhlow' with: [ spec repository: 'github://feenkcom/gtoolkit-visualizer/src' ];
			baseline: 'GToolkitInspector' with: [ spec 	repository: 'github://feenkcom/gtoolkit-inspector/src' ]
	]
