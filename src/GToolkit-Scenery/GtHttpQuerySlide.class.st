Class {
	#name : #GtHttpQuerySlide,
	#superclass : #GtSlide,
	#category : #'GToolkit-Scenery'
}

{ #category : #'api - instantiation' }
GtHttpQuerySlide >> create [
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
	^ GtInspector createOnPlayBook: book
]
