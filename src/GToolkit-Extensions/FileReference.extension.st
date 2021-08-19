Extension { #name : 'FileReference' }

{ #category : '*GToolkit-Extensions' }
FileReference >> gtStyledCodeFor: aView [
	<gtView>
	| parser styler |
	(self isFile
		and: [ (parser := SmaCCParser allSubclasses
				detect: [ :each | each fileExtensions includes: '.' , self extension ]
				ifNone: [  ]) notNil and: [ (styler := parser gtStyler) notNil ] ])
		ifFalse: [ ^ aView empty ].
	^ aView textEditor
		title: 'Code';
		priority: 10;
		styler: styler;
		aptitude: BrGlamorousCodeEditorAptitude;
		text: [ self contents asRopedText ];
		actionDropdownButtonIcon: BrGlamorousVectorIcons hamburger
			content: [ :aButton :aBrTab |
				| parsers menuItems |
				parsers := SmaCCParser allSubclasses
					select: [ :each | each fileExtensions includes: '.' , self extension ].
				menuItems := parsers collect: [ :each | 
					'Parse with ' , each name -> [ :anElement | aButton phlow spawnObject: (self smaCCParseUsing: each) ] ].
				
				BrGlamorousSimpleContextMenuContent new
					items: menuItems;
					hMatchParent;
					vMatchParent ]
]
