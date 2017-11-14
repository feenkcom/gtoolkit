baseline
baseline: spec
	<baseline>
	spec for: #common do: [ 
		spec
			baseline: 'Brick' with: [ spec
				repository: 'github://pharo-graphics/Brick/src';
				loads: #core ];
			baseline: 'GToolkitExamples' with: [ spec 
				repository: 'github://feenkcom/gtoolkit-examples/src' ];
			package: 'GToolkit-Connector' with: [ spec requires: #(#Brick #GToolkitExamples) ]
	]
