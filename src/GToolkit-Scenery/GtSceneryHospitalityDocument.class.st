Class {
	#name : #GtSceneryHospitalityDocument,
	#superclass : #GtScenery,
	#category : #'GToolkit-Scenery'
}

{ #category : #'world menu' }
GtSceneryHospitalityDocument class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: self name)
		order: 250.0; 
		parent: #GToolkitScenery;
		label: 'Hospitality document';
		action: [self new setUp]
]

{ #category : #initialization }
GtSceneryHospitalityDocument >> setUp [
	| book |
	book := GtPlayBook new.
	book pages first snippets first sourceCode: 'IceRepository repositoriesLocation / ''feenkcom''/ ''hospitality-reference-model'' / ''doc'' / ''index.pillar'''.
	(GtInspector openOnPlayBook: book)
]
