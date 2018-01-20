baseline
baseline: spec
	<baseline>
	spec for: #common do: [ 
		spec
			baseline: 'GToolkitDocumenter' with: [ spec repository: 'github://feenkcom/gtoolkit/src' ];
			baseline: 'GToolkitTranscript' with: [ spec repository: 'github://feenkcom/gtoolkit/src' ];
			baseline: 'GToolkitVisualizer' with: [ spec repository: 'github://feenkcom/gtoolkit-visualizer/src' ]
	]
