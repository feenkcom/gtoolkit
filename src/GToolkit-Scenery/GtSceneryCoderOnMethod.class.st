Class {
	#name : #GtSceneryCoderOnMethod,
	#superclass : #GtScenery,
	#category : #'GToolkit-Scenery'
}

{ #category : #'world menu' }
GtSceneryCoderOnMethod class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: self name)
		order: 440.0; 
		parent: #GToolkitScenery;
		label: 'Coder: Method';
		action: [self new setUp]
]

{ #category : #initialization }
GtSceneryCoderOnMethod >> setUp [
	| book |
	book := GtPlayBook newDefault.
	book pages first snippets first sourceCode: 'Object>>#printOn:'.	
	GtInspector openOnPlayBook: book
]
