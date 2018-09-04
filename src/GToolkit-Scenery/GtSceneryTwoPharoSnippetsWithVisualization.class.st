Class {
	#name : #GtSceneryTwoPharoSnippetsWithVisualization,
	#superclass : #GtScenery,
	#category : #'GToolkit-Scenery'
}

{ #category : #'world menu' }
GtSceneryTwoPharoSnippetsWithVisualization class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: self name)
		order: 300.0; 
		parent: #GToolkitScenery;
		label: 'Two Pharo snippets with visualization';
		action: [self new setUp]
]

{ #category : #initialization }
GtSceneryTwoPharoSnippetsWithVisualization >> setUp [
	| book |
	book := GtPlayBook new.
	book pages first snippets first sourceCode: 'directories := ''feenkcom'' asFileReference allDirectories'.
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
