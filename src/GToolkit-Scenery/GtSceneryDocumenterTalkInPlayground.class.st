Class {
	#name : #GtSceneryDocumenterTalkInPlayground,
	#superclass : #GtScenery,
	#category : #'GToolkit-Scenery'
}

{ #category : #'world menu' }
GtSceneryDocumenterTalkInPlayground class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: self name)
		order: 223.0; 
		parent: #GToolkitScenery;
		label: 'Documenter: Three Use Case Scenarios Talk in Playground';
		action: [self new setUp]
]

{ #category : #initialization }
GtSceneryDocumenterTalkInPlayground >> setUp [
	| aRegistry aFileReference aPlayBook aPlayPage aSnippet | 
	aRegistry := IceRepository registry detect: [ :each | each name = 'gtoolkit-demos' ].
	aFileReference := aRegistry location / 'doc' / 'tutorial' / 'esug-2018-documenter' / 'documenter.pillar'.
	aPlayBook := GtPlayBook new.
	aPlayPage := GtPlayPage new.
	aPlayPage bindings at: #aDocumenterTalkFile put: aFileReference.
	aSnippet := GtPharoSnippet new sourceCode: 'aDocumenterTalkFile'.
	aPlayBook addPlayPage: (aPlayPage addSnippet: aSnippet).
	aSnippet := GtPharoSnippet new sourceCode: 'Object subclass: #EsugDemo
	instanceVariableNames: ''''
	classVariableNames: ''''
	package: ''EsugDemo'''.
	aPlayPage addSnippet: aSnippet.
	aSnippet := GtPharoSnippet new sourceCode: '"logo"
	"<gtExample>"
	^ PolymorphSystemSettings desktopLogo'.
	aPlayPage addSnippet: aSnippet.
	aSnippet := GtPharoSnippet new sourceCode: '"set to 400"
	GtDocumenterConstants class>>#exactPreviewHeight'.
	aPlayPage addSnippet: aSnippet.
	
	GtInspector openOnPlayBook: aPlayBook
]
