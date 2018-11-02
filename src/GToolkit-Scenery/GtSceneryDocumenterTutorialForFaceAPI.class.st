Class {
	#name : #GtSceneryDocumenterTutorialForFaceAPI,
	#superclass : #GtScenery,
	#category : #'GToolkit-Scenery'
}

{ #category : #initialization }
GtSceneryDocumenterTutorialForFaceAPI >> setUp [
	| book |
	book := GtPlayBook newDefault.
	book pages first snippets first sourceCode: 'IceLibgitRepository repositoriesLocation / ''feenkcom''/ ''gtoolkit-demos'' / ''doc'' / ''tutorial'' / ''esug-2018'' / ''esug-2018-exemplifying-software.pillar'''.
	(GtInspector openOnPlayBook: book)
]
