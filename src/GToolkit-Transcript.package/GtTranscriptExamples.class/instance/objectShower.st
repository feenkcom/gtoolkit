examples
objectShower
	<gtExample>
	| geometries transcript loop |

	transcript := GtTranscript new.

	geometries := { BlEllipse . BlRectangle }.

	loop := [
		| index |
		index := 1.
		1000 timesRepeat: [
			| color size geometry |
	
			color := Color random paler.
			size := (100 atRandom @ 100 atRandom) + (75 @ 50).
			geometry := geometries atRandom new.

			transcript next
				cr;
				putAll: 'Rectangle ';
				put: index;
				expanded: [ BlElement new
					constraintsDo: [ :c | c textFlow pushLine ];
					geometry: geometry;
					size: size;
					background: color ];
				space.

			index := index + 1.
			20 milliSeconds wait
	] ] newProcess.

	loop resume.

	^ transcript

"
loop terminate
"