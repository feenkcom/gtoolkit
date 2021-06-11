"
See {{gtPage:How to create a standalone app|db=2j9m7db2i4oz116bexd7wbdxo}}
"
Class {
	#name : #GtCreateStandaloneAppHowToGuide,
	#superclass : #Object,
	#category : #'GToolkit-Docs'
}

{ #category : #accessing }
GtCreateStandaloneAppHowToGuide >> closeGtWorlds [
	<gtExample>
	<noTest>
	
	^ GtWorld allInstances do: [ :eachWorld | eachWorld close ]
]

{ #category : #accessing }
GtCreateStandaloneAppHowToGuide >> disableGtWorldShutdownHadler [
	<gtExample>
	<noTest>
	
	^ GtWorld allInstances do: [ :eachWorld | eachWorld removeShutdownListener ]
]

{ #category : #examples }
GtCreateStandaloneAppHowToGuide >> helloWorldScene [
	<gtExample>
	| aContainer |
	
	aContainer := BrVerticalPane new
		matchParent;
		alignCenter.
		
	aContainer addChild: (BrLabel new
		aptitude: (BrGlamorousLabelAptitude new fontSize: 30);
		text: 'Hello world!').
		
	^ aContainer
]

{ #category : #examples }
GtCreateStandaloneAppHowToGuide >> helloWorldSceneInSpace [
	<gtExample>
	<noTest>
	| aSpace |
	
	aSpace := BlSpace new
		addChild: self helloWorldScene;
		extent: 800@600;
		title: 'Hello World'.

	^ aSpace show
]

{ #category : #accessing }
GtCreateStandaloneAppHowToGuide >> saveTheImage [
	<gtExample>
	<noTest>
	
	^ Smalltalk snapshot: true andQuit: false
]
