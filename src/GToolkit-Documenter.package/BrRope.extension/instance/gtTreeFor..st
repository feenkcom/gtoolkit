*GToolkit-Documenter
gtTreeFor: aView
	^ aView 
		title: 'Tree';
		stencil: [ 
			| mondrian |
			mondrian := GtMondrian new.
			self paintTreeWith: mondrian.
			mondrian asPannableElement ]