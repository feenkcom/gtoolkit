accessing
affect: aBrText in: aBrEditor

	^ BlElement new
		size: self image extent;
		constraintsDo: [ :c | c textFlow pushLine ];
		background: (BlBackground builder image: self image; build);
		yourself