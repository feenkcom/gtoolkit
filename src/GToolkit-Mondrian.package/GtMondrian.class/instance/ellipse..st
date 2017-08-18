scripting - shape
ellipse: aBlock
	self shape: [ :anObject :anElement |
		aBlock 
			cull: anObject 
			cull: (anElement geometry: BlEllipse new) ]