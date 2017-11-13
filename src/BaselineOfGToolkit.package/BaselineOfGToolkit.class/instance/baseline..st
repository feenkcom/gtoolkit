baseline
baseline: spec
	<baseline>
	spec for: #common do: [ 
		spec
			baseline: 'GToolkitDocumenter' with: [ spec repository: 'github://feenkcom/gtoolkit/src' ];
			baseline: 'GToolkitConnector' with: [ spec repository: 'github://feenkcom/gtoolkit/src' ];
			baseline: 'GToolkitTranscript' with: [ spec repository: 'github://feenkcom/gtoolkit/src' ];
			baseline: 'GToolkitMondrian' with: [ spec repository: 'github://feenkcom/gtoolkit-visualizer/src' ]
	]
