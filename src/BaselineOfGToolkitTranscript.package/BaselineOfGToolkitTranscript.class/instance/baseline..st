baseline
baseline: spec
	<baseline>
	spec for: #common do: [ 
		spec
			baseline: 'Brick' with: [ spec
				repository: 'github://pharo-graphics/Brick/src';
				loads: #core ];
			package: 'GToolkit-Transcript' with: [ spec requires: #(#Brick) ]
	]
