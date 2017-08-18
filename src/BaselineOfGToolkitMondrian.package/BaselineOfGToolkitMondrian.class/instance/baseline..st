baseline
baseline: spec
	<baseline>
	spec for: #common do: [ 
		spec
			baseline: 'Bloc' with: [ spec
				repository: 'github://pharo-graphics/Bloc/src';
				loads: #development ];
			package: 'GToolkit-Mondrian'
	]
