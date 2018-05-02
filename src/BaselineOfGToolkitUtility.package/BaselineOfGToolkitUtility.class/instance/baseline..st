baseline
baseline: spec
	<baseline>
	spec for: #common do: [ 
		spec
			package: 'GToolkit-Utility-File';
			package: 'GToolkit-Utility-Assertion';
			group: 'Core' with: #( 'GToolkit-Utility-File' 'GToolkit-Utility-Assertion' );
			group: 'default' with: #( 'Core' )
	]
