baseline
baseline: spec
	<baseline>
	spec for: #common do: [ 
		spec
			configuration: 'NeoJSON' with: [ 
				spec
					repository: 'http://smalltalkhub.com/mc/SvenVanCaekenberghe/Neo/main/';
					versionString: #stable;
					loads: 'default' ];
			package: 'GToolkit-Publisher-Core' with: [ 
				spec requires: #( #NeoJSON ) ];
			package: 'GToolkit-Publisher-Client' with: [ 
				spec requires: #( 'GToolkit-Publisher-Core' ) ];
			package: 'GToolkit-Publisher-Examples' with: [ 
				spec requires: #( 'GToolkit-Publisher-Core' 'GToolkit-Publisher-Client' ) ];
			group: 'Core' with: #( 'GToolkit-Publisher-Core' 'GToolkit-Publisher-Client' );
			group: 'Tests' with: #( 'GToolkit-Publisher-Examples' );
			group: 'default' with: #( 'Core' 'Tests' )
	]
