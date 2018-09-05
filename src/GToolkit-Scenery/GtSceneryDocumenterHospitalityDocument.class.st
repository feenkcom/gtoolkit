Class {
	#name : #GtSceneryDocumenterHospitalityDocument,
	#superclass : #GtScenery,
	#category : #'GToolkit-Scenery'
}

{ #category : #'world menu' }
GtSceneryDocumenterHospitalityDocument class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: self name)
		order: 250.0; 
		parent: #GToolkitScenery;
		label: 'Documenter: Hospitality document';
		action: [self new setUp]
]

{ #category : #initialization }
GtSceneryDocumenterHospitalityDocument >> setUp [
	| book |
	book := GtPlayBook new.
	book pages first snippets first sourceCode: 'IceRepository repositoriesLocation / ''feenkcom''/ ''hospitality-reference-model'' / ''doc'' / ''index.pillar'''.
	(GtInspector openOnPlayBook: book)
]
