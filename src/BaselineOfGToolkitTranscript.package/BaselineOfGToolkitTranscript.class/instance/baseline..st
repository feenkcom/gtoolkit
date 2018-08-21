baseline
baseline: spec
	<baseline>
	spec for: #common do: [ 
		spec
			baseline: 'Brick' with: [ spec repository: 'github://pharo-graphics/Brick/src' ];
			package: 'GToolkit-Transcript' with: [ spec requires: #(#Brick) ]
	]
