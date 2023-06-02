Extension { #name : #FileReference }

{ #category : #'*GToolkit-Extensions' }
FileReference >> gtStyledCodeFor: aView [
	<gtView>
	| parser styler |
	(self isFile
		and: [ (parser := SmaCCParser allSubclasses
					detect: [ :each | each fileExtensions includes: '.' , self extension ]
					ifNone: [  ]) notNil and: [ (styler := parser gtStyler) notNil ] ])
		ifFalse: [ ^ aView empty ].

	^ aView explicit
		title: 'Code';
		priority: 10;
		stencil: [ | pane |
			pane := self gtEditorView.
			pane
				childNamed: #editor
				ifFound: [ :editor | 
					editor aptitude: BrGlamorousCodeEditorAptitude.
					editor editor styler: styler ].
			pane ];
		actionDropdownButtonIcon: BrGlamorousVectorIcons hamburger
			content: [ :aButton :aBrTab | 
				| parsers menuItems |
				parsers := SmaCCParser allSubclasses
						select: [ :each | each fileExtensions includes: '.' , self extension ].
				menuItems := parsers
						collect: [ :each | 
							('Parse with ' , each name)
								-> [ :anElement | aButton phlow spawnObject: (self smaCCParseUsing: each) ] ].

				BrGlamorousSimpleContextMenuContent new
					items: menuItems;
					hMatchParent;
					vMatchParent ]
]
