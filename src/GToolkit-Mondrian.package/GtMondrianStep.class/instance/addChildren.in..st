accessing
addChildren: aCollection in: aSymbol
	"At this stage we need to gather the elements that can contain children from the child.
	We do not want to do it later, because at a later time we might have other Mondrian child nodes
	that also appear as Bloc elements"
	aCollection do: [ :each | each identifyMondrianChildrenContainers ].
	root addChildren: aCollection inMondrianChildrenContainer: aSymbol