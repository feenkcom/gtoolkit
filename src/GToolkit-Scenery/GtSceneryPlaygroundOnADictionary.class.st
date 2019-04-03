Class {
	#name : #GtSceneryPlaygroundOnADictionary,
	#superclass : #GtScenery,
	#category : #'GToolkit-Scenery'
}

{ #category : #'world menu' }
GtSceneryPlaygroundOnADictionary class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: self name)
		order: 400.0; 
		parent: #GToolkitScenery;
		label: 'Playground: dictionary';
		action: [self new setUp]
]

{ #category : #initialization }
GtSceneryPlaygroundOnADictionary >> setUp [
	| book |
	book := GtPlayBook newDefault.
	book pages first snippets first sourceCode: '{
	#number -> 42 . 
	#date -> Date today.
	#color -> Color cyan.
	#string -> ''fourty-two'' . 
	 } 
		asDictionary'.	
	GtInspector openOnPlayBook: book
]
