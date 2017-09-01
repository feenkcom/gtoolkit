private
exampleMethodsDo: aBlock
	self source theNonMetaClass methods
		select: [ :each | self isExampleMethod: each ]
		thenDo: aBlock.
	self source theMetaClass methods
		select: [ :each | self isExampleMethod: each ]
		thenDo: aBlock.
		