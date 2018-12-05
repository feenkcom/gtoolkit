Class {
	#name : #GtSceneryTranscriptAPI,
	#superclass : #GtScenery,
	#category : #'GToolkit-Scenery'
}

{ #category : #'world menu' }
GtSceneryTranscriptAPI class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: self name)
		order: 900.0; 
		parent: #GToolkitScenery;
		label: 'Transcript: API';
		action: [self new setUp]
]

{ #category : #initialization }
GtSceneryTranscriptAPI >> setUp [
	| book |
	book := GtPlayBook newDefault.
	book pages first snippets first sourceCode: 'transcript := GtTranscript new'.
	book pages first addSnippet: GtCoderSnippet new.
	book pages first snippets last sourceCode: 'transcript 
	nextPutAll: ''This is an example of'';
	space;
	nextPutAll: ''the new GT Transcript'';
	nextPut: ''.'';
	cr.'.
	book pages first addSnippet: GtCoderSnippet new.
	book pages first snippets last sourceCode: 'transcript next
	putAll: ''Beside typical text, it can also handle:'';
	cr.
transcript next
	tab;
	color: Color blue;
	putAll: ''Colored text'';
	cr.
transcript tab.
transcript next	
	fontSize: 20;
	putAll: ''Varying size text'';
	cr.'.
	book pages first addSnippet: GtCoderSnippet new.
	book pages last snippets last sourceCode: 'transcript next
	tab;
	expanding: [ BlElement new background: Color indexedColors atRandom; yourself ];
	putAll: ''Embelished with extra expansion''.
transcript cr.'.
	book pages first addSnippet: GtCoderSnippet new.
	book pages last snippets last sourceCode: '[ 1/0 ] on: Error do: [ :err | 
	transcript next 
		tab;
		putAll: ''Exception: '';
		showException: err;
		cr ].'.
"	book pages first addSnippet: GtCoderSnippet new."

	GtInspector openOnPlayBook: book
]
