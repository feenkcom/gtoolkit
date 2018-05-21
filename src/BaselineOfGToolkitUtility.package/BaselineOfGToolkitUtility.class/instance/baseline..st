baseline
baseline: spec
	<baseline>
	spec for: #common do: [ 
		spec
			package: 'GToolkit-Utility-File';
			package: 'GToolkit-Utility-Assertion';
			package: 'GToolkit-Utility-Announcer';
			package: 'GToolkit-Utility-System' with: [
				spec requires: #( 'GToolkit-Utility-Assertion' ) ];
			group: 'default' with: #( 
				'GToolkit-Utility-Assertion'
				'GToolkit-Utility-Announcer'
				'GToolkit-Utility-File' 
				'GToolkit-Utility-System' )
	]
