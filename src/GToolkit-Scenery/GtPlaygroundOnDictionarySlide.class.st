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
	#number -> 42 . 
	#date -> Date today.
	#color -> Color cyan.
	#string -> ''fourty-two'' . 
	 } 
		asDictionary'.	
	^ GtInspector createOnPlayBook: book
]
