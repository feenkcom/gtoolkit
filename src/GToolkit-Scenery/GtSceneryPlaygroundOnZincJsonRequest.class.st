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
		label: 'Playground: Zinc JSON';
		action: [self new setUp]
]

{ #category : #initialization }
GtSceneryPlaygroundOnZincJsonRequest >> setUp [
	| book |
	book := GtPlayBook newDefault.
	book pages first snippets first sourceCode: 'url := ''https://blog.feenk.com'' asZnUrl 
		/ XdConstants cdnPathSegments
		/ XdConstants listFileName'.
	book pages first addSnippet: GtCoderSnippet new.
	book pages last snippets last sourceCode: 'ZnClient new
	url: url;
	get;
	response'.	
	GtInspector openOnPlayBook: book
]
