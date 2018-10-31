Class {
	#name : #GtSceneryPlaygroundTwoPharoSnippetsWithVisualization,
	#superclass : #GtScenery,
	#category : #'GToolkit-Scenery'
}

{ #category : #'world menu' }
GtSceneryPlaygroundTwoPharoSnippetsWithVisualization class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: self name)
		order: 415.0; 
		parent: #GToolkitScenery;
		label: 'Playground: Two Pharo snippets with visualization';
		action: [self new setUp];
		withSeparatorAfter
]

{ #category : #initialization }
GtSceneryPlaygroundTwoPharoSnippetsWithVisualization >> setUp [
	| book |
	book := GtPlayBook newDefault.
	book pages first snippets first sourceCode: 'directories := (IceLibgitRepository repositoriesLocation / ''feenkcom'')
	allDirectories 
	select: [:each | 
		(each fullName includesSubstring: ''gtoolkit'') and: [
			(each fullName includesSubstring: ''git'') not]]'.
	book pages first addSnippet: GtPharoSnippet new.
	book pages last snippets last sourceCode: 'mondrian := GtMondrian new.
mondrian nodes 
	stencil: [:dir | 
		BlTextElement new text: dir basename asRopedText ];
	with: directories.
mondrian edges 
	fromRightCenter;
	toLeftCenter;
	connectFrom: #parent.
mondrian layout horizontalTree.
mondrian'.
	
	GtInspector openOnPlayBook: book
]
