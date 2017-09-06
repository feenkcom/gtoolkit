*GToolkit-Mondrian
addChild: anElement inMondrianChildrenContainer: aSymbol
	^ ((self mondrianChildrenContainers) at: aSymbol ifAbsent: [self]) addChild: anElement