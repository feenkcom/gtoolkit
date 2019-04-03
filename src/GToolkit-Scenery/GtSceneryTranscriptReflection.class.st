Class {
	#name : #GtSceneryTranscriptReflection,
	#superclass : #GtScenery,
	#category : #'GToolkit-Scenery'
}

{ #category : #'world menu' }
GtSceneryTranscriptReflection class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: self name)
		order: 910.0; 
		parent: #GToolkitScenery;
		label: 'Transcript: Reflection';
		action: [self new setUp];
		withSeparatorAfter
]

{ #category : #initialization }
GtSceneryTranscriptReflection >> setUp [
	| book |
	book := GtPlayBook newDefault.
	book pages first snippets first sourceCode: 'transcript := GtTranscript new'.
	book pages first addSnippet: GtCoderSnippet new.
	book pages first snippets last sourceCode: 'i := 1.
process := [
     [ true ] whileTrue: [
          transcript show: ''Question '', i asString, '': ''.
          ([transcript show: Object answer; cr] on: Error do: [:e | transcript showException: e]).
          i := i + 1.
          (Delay forMilliseconds: 200) wait. ]
] fork.'.
	book pages first addSnippet: GtCoderSnippet new.
	book pages first snippets last sourceCode: 'Object
  compile: ''answer ^ 41''
  classified: ''extension''.'.
	book pages first addSnippet: GtCoderSnippet new.
	book pages last snippets last sourceCode: 'Object removeSelector: #answer.'.
	book pages first addSnippet: GtCoderSnippet new.
	book pages last snippets last sourceCode: 'process terminate'.

	GtInspector openOnPlayBook: book
]
