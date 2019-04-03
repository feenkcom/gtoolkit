Class {
	#name : #GtSceneryPlaygroundOnePharoSnippetWithVisualization,
	#superclass : #GtScenery,
	#category : #'GToolkit-Scenery'
}

{ #category : #'world menu' }
GtSceneryPlaygroundOnePharoSnippetWithVisualization class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: self name)
		order: 408.0; 
		parent: #GToolkitScenery;
		label: 'Pl: One snippet with visualization';
		action: [self new setUp]
]

{ #category : #initialization }
GtSceneryPlaygroundOnePharoSnippetWithVisualization >> setUp [
	| book aSubDirectories aFileReference |
	book := GtPlayBook newDefault.
	aSubDirectories := #allDirectories.
	aFileReference := 'feenk' asFileReference.
	aFileReference exists ifFalse: [ 
		aFileReference := GtIcebergUtility documentAtPath: 'feenkcom'.
		aSubDirectories := #directories ].
	book pages first snippets first sourceCode: 'rootDirectory := ', aFileReference fullName printString, ' asFileReference.
directories := Array with: rootDirectory withAll: rootDirectory ', aSubDirectories asString, '.
mondrian := GtMondrian new.
mondrian nodes 
	stencil: [:dir | 
		BrLabel new text: dir basename asRopedText; look: BrGlamorousLabelLook ];
	with: directories.
mondrian edges 
	fromRightCenter;
	toLeftCenter;
	connectFrom: #parent.
mondrian layout horizontalTree.
mondrian'.
	
	GtInspector openOnPlayBook: book
]
