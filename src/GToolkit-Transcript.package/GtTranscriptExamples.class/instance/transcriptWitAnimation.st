examples
transcriptWitAnimation
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