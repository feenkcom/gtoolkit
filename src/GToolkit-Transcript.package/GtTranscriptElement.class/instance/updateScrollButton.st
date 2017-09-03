updating
updateScrollButton

	self isAutoScrollEnabled
		ifTrue: [ scrollButtonElement border: (BlBorder builder width: 5; paint: Color green twiceDarker; build) ]
		ifFalse: [ scrollButtonElement border: (BlBorder builder width: 5; paint: Color lightGray; build) ]