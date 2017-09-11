*GToolkit-Mondrian
addChildren: aCollection inMondrianChildrenContainer: aSymbol 
	^ ((self mondrianChildrenContainers) at: aSymbol ifAbsent: [self]) addChildren: aCollection