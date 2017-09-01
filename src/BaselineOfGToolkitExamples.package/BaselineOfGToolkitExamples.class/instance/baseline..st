baseline
baseline: spec
	<baseline>
	spec for: #common do: [ 
		spec
			package: 'GToolkit-Examples';
			package: 'GToolkit-Examples-Dummies' with: [ spec requires: #('GToolkit-Examples') ]
	]
