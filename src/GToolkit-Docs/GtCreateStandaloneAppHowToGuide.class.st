"
!How to create a standalone app with GT
To create a standalone app based on the Glamorous Toolkit it is required to open an application specific window with the graphical scene and close the rest of GT windows. This can be done in just a few steps.
!!!Open a basic space with a scene
${class:BlSpace}$ is responsible for displaying a scene in a separate window. Users can customise window's title or extent. To spawn a window send ${method:BlSpace>>#show}$ to an instance of the space.
${example:GtCreateStandaloneAppHowToGuide>>#helloWorldSceneInSpace}$
!!Cleaning up the existing windows
The Glamorous Toolkit comes with a ${class:GtWorld}$ opened by default. When creating a standalone app based on GT we should close that window, which can be done in two steps.
!!!Disable shutdown-on-close listener
In order to shutdown the process when a window is closed, we add a ${class:BlSpaceShutdownOnCloseListener}$ as an event handler to a ${class:BlSpace}$. It should be removed before we close such spaces.
${example:GtCreateStandaloneAppHowToGuide>>#disableGtWorldShutdownHadler}$
!!!Closing an existing GtWorld
To close an opened window, it is enough to just send ${method:BlSpace>>#close}$ to an intended space.
${example:GtCreateStandaloneAppHowToGuide>>#closeGtWorlds}$
!!Save the image
Once the indended appliocation window is opened and there are no more GT windows we can save the image (without quitting):
${example:GtCreateStandaloneAppHowToGuide>>#saveTheImage}$
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
		look: (BrGlamorousLabelLook new fontSize: 30);
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
		title: 'Hello World';
		show.

	^ aSpace
]

{ #category : #accessing }
GtCreateStandaloneAppHowToGuide >> saveTheImage [
	<gtExample>
	<noTest>
	
	^ Smalltalk snapshot: true andQuit: false
]
