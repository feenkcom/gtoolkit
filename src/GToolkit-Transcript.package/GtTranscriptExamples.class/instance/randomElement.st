instance creation
randomElement
	<gtExample>
	| geometries color size geometry |
	
	geometries := { BlEllipse . BlRectangle }.
	color := Color random paler.
	size := (100 atRandom @ 100 atRandom) + (75 @ 50).
	geometry := geometries atRandom new.
		
	^ BlElement new
		constraintsDo: [ :c | c textFlow pushLine ];
		geometry: geometry;
		size: size;
		background: color;
		"to allow transcript to log measured size"
		forceLayout