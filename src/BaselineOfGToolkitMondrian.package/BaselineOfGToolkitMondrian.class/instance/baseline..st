baseline
baseline: spec
	<baseline>
	spec
		for: #common
		do: [ spec
				baseline: 'Bloc'
					with: [ spec
						repository: 'github://pharo-graphics/Bloc/src';
						loads: #development ];
				package: 'GToolkit-Mondrian' with: [ spec requires: #(#Bloc) ];
				package: 'GToolkit-Mondrian-Layouts' with: [ spec requires: #(#'GToolkit-Mondrian') ];
				package: 'GToolkit-Mondrian-Glamour' with: [ spec requires: #(#'GToolkit-Mondrian') ] ]