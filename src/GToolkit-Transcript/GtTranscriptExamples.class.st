Class {
	#name : #GtTranscriptExamples,
	#superclass : #Object,
	#category : 'GToolkit-Transcript'
}

{ #category : #examples }
GtTranscriptExamples >> blocAnimation [
	<gtExample>
	| animation childTranslate1 element backgroundAnimation childTranslate2 scaleIncrease childTranslate child |
	element := BlElement new.
	element size: 50 @ 50.
	element relocate: 50@50.
	element
		background: Color red twiceDarker;
		border: (BlBorder paint: Color lightGray width: 5).
	child := BlElement new
		size: 10 @ 10;
		geometry: BlEllipse new;
		background: Color white.
	element addChild: child.
	backgroundAnimation := BlColorTransition new
		target: element;
		duration: 5 seconds;
		from: Color red twiceDarker;
		to: Color blue twiceDarker;
		onStepDo: [ :aColor | element background: aColor ].
	scaleIncrease := (BlTransformAnimation scale: 3@3)
		duration: 5 seconds;
		yourself.
	childTranslate1 := (BlTransformAnimation translate: 35 @ 20)
		target: child;
		duration: 2.5 seconds.
	childTranslate2 := (BlTransformAnimation translate: -30 @ 15)
		target: child;
		duration: 2.5 seconds.
	childTranslate := BlSequentialAnimation new
		target: element;
		addAll:
			{childTranslate1.
			childTranslate2}.
	animation := BlParallelAnimation new
		target: element;
		addAll:
			{backgroundAnimation.
			scaleIncrease.
			childTranslate}.
	^ animation
]

{ #category : #examples }
GtTranscriptExamples >> blocElementWithAnimation [
	<gtExample>
	^ self blocAnimation 
		start; 
		target
]

{ #category : #examples }
GtTranscriptExamples >> characterWithAdornment [
	<gtExample>
	| transcript |
	transcript := self transcript.
	transcript next
		expanding: [ BlElement new size: 70 @ 50; background: Color blue; yourself ]; 
		put: $4.
	transcript next put: $2.
	^ transcript
]

{ #category : #examples }
GtTranscriptExamples >> characters [
	<gtExample>
	| transcript |
	transcript := self transcript.
	transcript next put: $4.
	transcript next put: $2.
	^ transcript
]

{ #category : #examples }
GtTranscriptExamples >> completeAPI [
	<gtExample>
	| transcript |
	transcript := self transcript.
	transcript 
		nextPutAll: 'This is an example of';
		space;
		nextPutAll: 'the new GT Transcript';
		nextPut: '.';
		cr.
	transcript next
		putAll: 'Beside typical text, it can also handle:';
		cr.
	transcript next
		tab;
		color: Color blue;
		putAll: 'Colored text';
		cr.
	transcript tab.
	transcript next	
		fontSize: 20;
		putAll: 'Varying size text';
		cr.
	transcript next
		tab;
		expanding: [ BlElement new background: Color indexedColors atRandom; yourself ];
		putAll: 'Embelished with extra expansion';
		cr.
	[ 1/0 ] on: Error do: [ :err | 
		transcript next 
			tab;
			putAll: 'Exception: ';
			showException: err;
			cr ].
	transcript next 
		tab;
		italic;
		streamAll: [ transcript next putAll: 'And others ...' ].
	^ transcript 
]

{ #category : #examples }
GtTranscriptExamples >> error [
	<gtExample>
	| transcript |
	transcript := self transcript.
	[ 1/0 ] on: Error do: [ :err | 
		transcript next 
			putAll: 'Exception: ';
			showException: err ].
	^ transcript
]

{ #category : #examples }
GtTranscriptExamples >> objectShower [
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
]

{ #category : #examples }
GtTranscriptExamples >> putAll [
	<gtExample>
	| transcript |
	transcript := self transcript.
	transcript next putAll: '42'.
	^ transcript
]

{ #category : #'instance creation' }
GtTranscriptExamples >> randomElement [
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
]

{ #category : #examples }
GtTranscriptExamples >> stringWithAdornment [
	<gtExample>
	| transcript |
	transcript := self transcript.
	transcript next
		expanding: [ BlElement new size: 70 @ 50; background: Color blue; yourself ]; 
		putAll: '42'.
	^ transcript
]

{ #category : #examples }
GtTranscriptExamples >> transcript [
	<gtExample>
	^ GtTranscript new
]

{ #category : #examples }
GtTranscriptExamples >> transcriptWitAnimation [
	<gtExample>
	| animation transcript |
	transcript := self transcript.
	animation := self blocAnimation.
	animation start.
	animation
		addEventHandlerOn: BlAnimationStepEvent
		do: [ :anEvent | 
			| snapshot |
			snapshot := animation target asSpartaForm.
			transcript next
				cr;
				expanded: [ BlElement new
						constraintsDo: [ :c | c textFlow pushLine ];
						size: snapshot extent;
						background:
							(BlBackground builder
								image: snapshot;
								build) ];
				putAll: 'Animation progress:';
				space;
				put: anEvent progress asString.
			animation target asSpartaForm extent ].
	^ transcript
]
