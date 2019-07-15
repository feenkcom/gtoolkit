Class {
	#name : #GtPlaygroundOnDictionarySlide,
	#superclass : #GtSlide,
	#category : #'GToolkit-Scenery'
}

{ #category : #'api - instantiation' }
GtPlaygroundOnDictionarySlide >> create [
	| book |
	book := GtPlayBook newDefault.
	book pages first snippets first sourceCode: '{
	#number -> (21/2) . 
	#color -> Color cyan.
	#string -> ''A string is a basic data structure.
What could we possibly see different about it?''. 
	 } 
		asDictionary'.	
	^ GtInspector createOnPlayBook: book
]
