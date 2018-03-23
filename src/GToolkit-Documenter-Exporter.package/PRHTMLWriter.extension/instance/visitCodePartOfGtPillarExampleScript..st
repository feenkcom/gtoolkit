*GToolkit-Documenter-Exporter
visitCodePartOfGtPillarExampleScript: aScript
	canvas tag
		name: 'figure';
		parameterAt: 'class' put: 'gtexample-src';
		with: [ 
					canvas tag
						name: 'pre';
						with: [ 
									| code language |
									code := canvas tag
										name: 'code';
										yourself.
									language := self languageForScript: aScript.
									language isSyntaxHighlightingPossible
										ifTrue: [ code parameterAt: 'class' put: language printString ].
									code with: [ canvas lines: aScript text ] ].
					canvas tag
						name: 'figcaption';
						with: [ 
									aScript hasLabel
										ifTrue: [ 
											self createAnchorWith: aScript label.
											self writeCounterForScript: aScript ].
									aScript hasCaption
										ifTrue: [ self visitAll: aScript caption children ] ] ].
	canvas newLine