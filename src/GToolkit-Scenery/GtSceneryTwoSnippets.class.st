Class {
	#name : #GtSceneryTwoSnippets,
	#superclass : #GtScenery,
	#category : #'GToolkit-Scenery'
}

{ #category : #'world menu' }
GtSceneryTwoSnippets class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: self name)
		order: 200.0; 
		parent: #GToolkitScenery;
		label: 'Two snippets';
		action: [self new setUp]
]

{ #category : #initialization }
GtSceneryTwoSnippets >> setUp [
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
