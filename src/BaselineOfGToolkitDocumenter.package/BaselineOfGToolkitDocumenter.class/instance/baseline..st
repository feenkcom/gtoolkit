baseline
baseline: spec
	<baseline>
	spec for: #common do: [ 
		spec
			baseline: 'Brick' with: [ spec
				repository: 'github://pharo-graphics/Brick/src';
				loads: #development ];
			project: 'Pier' with: [ spec
				className: #ConfigurationOfPier;
				versionString: #development;
				repository: 'http://smalltalkhub.com/mc/Pier/Pillar/main/' ];
			package: 'GToolkit-Documenter' with: [ spec requires: #(#Brick #Pier) ]
	]
