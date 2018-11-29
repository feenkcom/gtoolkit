Class {
	#name : #GtSceneryPlaygroundOnePharoSnippetWithFolder,
	#superclass : #GtScenery,
	#category : #'GToolkit-Scenery'
}

{ #category : #'world menu' }
GtSceneryPlaygroundOnePharoSnippetWithFolder class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: self name)
		order: 405.0; 
		parent: #GToolkitScenery;
		label: 'Playground: File system';
		action: [self new setUp]
]

{ #category : #initialization }
GtSceneryPlaygroundOnePharoSnippetWithFolder >> setUp [
	| aBook aFileReference |
	aBook := GtPlayBook newDefault.
	aFileReference := 'feenk' asFileReference.
	aFileReference exists ifFalse: [ 
		aFileReference := GtIcebergUtility documentAtPath: 'feenkcom' ].
	aBook pages first snippets first sourceCode: aFileReference fullName printString, ' asFileReference'.
	
	GtInspector openOnPlayBook: aBook
]
