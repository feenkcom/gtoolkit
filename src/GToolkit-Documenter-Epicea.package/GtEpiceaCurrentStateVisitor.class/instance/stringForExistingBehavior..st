visitor
stringForExistingBehavior: aClassOrTrait
	^ String streamContents: [ :stream |
		stream
			nextPutAll: aClassOrTrait definition;
			nextPut: $.;
			cr; cr;
			nextPutAll: aClassOrTrait theMetaClass definition ]