examples
objectShower
	<gtExample>
	| geometries transcript loop |

	transcript := GtTranscript new.

	geometries := { BlEllipse . BlRectangle }.

	loop := [
		| index |
		index := 1.
		500 timesRepeat: [
			transcript next
				cr;
				putAll: 'Element ';
				put: index;
				expanded: [ self randomElement ];
				space.

			index := index + 1.
			20 milliSeconds wait
	] ] newProcess.

	loop resume.

	^ transcript