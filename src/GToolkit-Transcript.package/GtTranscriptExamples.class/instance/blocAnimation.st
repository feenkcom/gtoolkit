examples
blocAnimation
	<gtExample>
	| animation childTranslate1 element backgroundAnimation childTranslate2 scaleIncrease childTranslate child |
	element := BlElement new.
	element size: 50 @ 50.
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
		duration: 5000;
		from: Color red twiceDarker;
		to: Color blue twiceDarker;
		onStepDo: [ :aColor | element background: aColor ].
	scaleIncrease := (BlTransformAnimation scale: 3@3)
		duration: 5000;
		yourself.
	childTranslate1 := (BlTransformAnimation translate: 35 @ 20)
		target: child;
		duration: 2500.
	childTranslate2 := (BlTransformAnimation translate: -30 @ 15)
		target: child;
		duration: 2500.
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