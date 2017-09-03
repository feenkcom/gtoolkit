examples
animation
	<gtExample>
	| element child backgroundAnimation scaleIncrease childTranslate1 childTranslate2 childTranslate animation transcript transcriptElement |
	
	element := BlElement new.
	element size: 50@50.
	element background: Color red.

	child := BlElement new
		size: 10@10;
		geometry: BlEllipse new;
		background: Color yellow.
	
	element addChild: child.

	backgroundAnimation := BlColorTransition new
		target: element;
		duration: 5000;
		from: Color red;
		to: Color blue;
		onStepDo: [ :aColor | element background: aColor ].

	scaleIncrease := BlScaleAnimation new
		scaleTo: 3@3;
		duration: 5000;
		yourself.

	childTranslate1 := BlTranslateAnimation new
		target: child;
		from: 0@0;
		to: 40@20;
		duration: 2500.
	
	childTranslate2 := BlTranslateAnimation new
		target: child;
		from: 40@20;
		to: 0@40;
		duration: 2500.

	childTranslate := BlSequentialAnimation new
		target: element;
		addAll: { childTranslate1 . childTranslate2 }.

	animation := BlParallelAnimation new
		target: element;
		addAll: { backgroundAnimation . scaleIncrease . childTranslate }.
	
	animation start.

	transcript := GtTranscript new.
	transcriptElement := transcript newEditorElement.

	animation addEventHandlerOn: BlAnimationStepEvent do: [ :anEvent |
		| snapshot |
		snapshot := animation target asSpartaForm.
		transcript next
			cr;
			expanded: [ BlElement new
				constraintsDo: [ :c |
					c textFlow pushLine ];
				size: snapshot extent;
				background: (BlBackground builder image: snapshot; build) ];
			putAll: 'Animation progress:';
			space;
			put: anEvent progress asString.
		animation target asSpartaForm extent ].
	
	^ transcriptElement