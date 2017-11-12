initialization
button
	^ button ifNil: [
		button := BlElement new
			size: 8 @ 8;
			margin:
				(BlInsets
					top: 2
					right: 5
					bottom: 0
					left: 5);
			background: Color gray;
			geometry: BlEllipse new;
			addEventHandlerOn: BlClickEvent
				do: [ :anEvent | actionBlock value: anEvent ];
			yourself.
		button userData at: #buttonAttributeTarget put: self target.
		button ]