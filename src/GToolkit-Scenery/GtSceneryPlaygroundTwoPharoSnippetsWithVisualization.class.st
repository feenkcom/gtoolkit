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
		label: 'Pl: Two snippets with visualization';
		action: [self new setUp];
		withSeparatorAfter
]

{ #category : #initialization }
GtSceneryPlaygroundTwoPharoSnippetsWithVisualization >> setUp [
	| aBook aPathConstructor |
	aBook := GtPlayBook newDefault.
	aPathConstructor := GtResourcesUtility name, 
		String space, #resourceAtPath: asString, String space, 'feenkcom' printString.
	aBook pages first snippets first sourceCode: 'directories := (', aPathConstructor, ')
	allDirectories 
	select: [:each | 
		(each fullName includesSubstring: ''gtoolkit'') and: [
			(each fullName includesSubstring: ''git'') not]]'.
	aBook pages first addSnippet: GtCoderSnippet new.
	aBook pages last snippets last sourceCode: 'mondrian := GtMondrian new.
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
	
	GtInspector openOnPlayBook: aBook
]
