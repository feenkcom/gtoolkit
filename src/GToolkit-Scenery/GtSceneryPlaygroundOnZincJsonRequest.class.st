Class {
	#name : #GtSceneryPlaygroundOnZincJsonRequest,
	#superclass : #GtScenery,
	#category : #'GToolkit-Scenery'
}

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
