Class {
	#name : #GtSceneryPlaygroundOnZincJsonRequest,
	#superclass : #GtScenery,
	#category : #'GToolkit-Scenery'
}

{ #category : #'world menu' }
GtSceneryPlaygroundOnZincJsonRequest class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: self name)
		order: 402.0; 
		parent: #GToolkitScenery;
		label: 'Playground: a Zinc JSON';
		action: [self new setUp]
]

{ #category : #initialization }
GtSceneryPlaygroundOnZincJsonRequest >> setUp [
	| book |
	book := GtPlayBook newDefault.
	book pages first snippets first sourceCode: 'ZnClient new
	url: ''https://blog.feenk.com'' asZnUrl 
		/ XdConstants cdnPathSegments
		/ XdConstants listFileName;
	get;
	response'.	
	GtInspector openOnPlayBook: book
]
