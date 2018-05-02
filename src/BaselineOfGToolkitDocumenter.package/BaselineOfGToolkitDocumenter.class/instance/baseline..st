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
			project: 'Pillar' with: [ spec
				className: #ConfigurationOfPillar;
				versionString: #development;
				repository: 'http://smalltalkhub.com/mc/Pier/Pillar/main/' ];
			project: 'DeepTraverser' with: [ spec
				className: #ConfigurationOfDeepTraverser;
				versionString: #development;
				repository: 'http://smalltalkhub.com/mc/Moose/DeepTraverser/main/' ];
			package: 'GToolkit-Documenter' with: [ spec requires: #(#Brick #Pillar #GToolkitExamples) ];
			package: 'GToolkit-Documenter-Exporter' with: [ spec requires: #( #Brick #Pillar ) ];
			package: 'GToolkit-Documenter-Exporter-Tests' with: [ spec requires: #( 'GToolkit-Documenter-Exporter' ) ];
			package: 'GToolkit-Documenter-Examples' with: [ spec requires: #( 
				'GToolkitExamples' 'GToolkit-Documenter' 'GToolkit-Documenter-Exporter' ) ];
			group: 'Core' with: #( 'GToolkit-Documenter' 'GToolkit-Documenter-Exporter' );
			group: 'Tests' with: #( 'GToolkit-Documenter-Exporter-Tests' );
			group: 'default' with: #( 'Core' 'Tests' )
	]
