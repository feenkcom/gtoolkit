baseline
baseline: spec
	<baseline>
	spec for: #common do: [ 
		spec
			package: 'GToolkit-Utility-File';
			group: 'Core' with: #( 'GToolkit-Utility-File' );
			group: 'default' with: #( 'Core' )
	]
