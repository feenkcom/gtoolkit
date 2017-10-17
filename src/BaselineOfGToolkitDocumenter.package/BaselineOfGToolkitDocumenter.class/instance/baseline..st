baseline
baseline: spec
	<baseline>
	spec for: #common do: [ 
		spec
			baseline: 'Brick' with: [ spec
				repository: 'github://pharo-graphics/Brick/src';
				loads: #development ];
			baseline: 'GToolkitExamples' with: [ spec 
				repository: 'github://feenkcom/gtoolkit-examples/src' ];
			project: 'Pillar' with: [ spec
				className: #ConfigurationOfPillar;
				versionString: #pier;
				repository: 'http://smalltalkhub.com/mc/Pier/Pillar/main/' ];
			package: 'GToolkit-Documenter' with: [ spec requires: #(#Brick #Pillar #GToolkitExamples) ]
	]
