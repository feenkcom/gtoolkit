baseline
baseline: spec
	<baseline>
	spec for: #common do: [ 
		spec
			package: 'GToolkit-Utility-File';
			package: 'GToolkit-Utility-Assertion';
			package: 'GToolkit-Utility-Announcer';
			group: 'default' with: #( 
				'GToolkit-Utility-File' 
				'GToolkit-Utility-Assertion'
				'GToolkit-Utility-Announcer' )
	]
