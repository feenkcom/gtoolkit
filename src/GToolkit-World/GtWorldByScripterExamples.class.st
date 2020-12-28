Class {
	#name : #GtWorldByScripterExamples,
	#superclass : #Object,
	#traits : 'TBlDevScripterExamples',
	#classTraits : 'TBlDevScripterExamples classTrait',
	#category : #'GToolkit-World-Examples'
}

{ #category : #'examples - coder' }
GtWorldByScripterExamples >> addCoderIntoTabElement [
	<gtExample>
	| aScripter |
	aScripter := self tabElementInScripter.

	aScripter substep: 'Add Coder as a World tab' do: [ :aStep |
		aStep do
			label: 'Show Coder space';
			block: [ :aTabElement | 
				| aStencil |
				aStencil := self coderStencil.
				GtWorldUtility 
					showSpaceWithIcon: aStencil icon 
					title: aStencil name 
					with: aStencil 
					from: aTabElement ].
			
		aStep check
			label: 'Check Coder in a new tab';
			value: [ :anElement | anElement tabs tabs size ]
			equals: 2.
			
		aStep check 
			label: 'Check Coder tab label';
			value: [ :anElement | anElement tabs tabs second widget label asString ]
			equals: 'Coder'.

		aStep check 
			label: 'Check Coder tab selection';
			satisfies: [ :anElement | anElement tabs tabs second isSelected ]
			description: [ 'Coder tab must be selected' ].
	].

	^ aScripter syncContinue
]

{ #category : #'examples - playground' }
GtWorldByScripterExamples >> addPlaygroundIntoTabElement [
	<gtExample>
	| aScripter |
	aScripter := self tabElementInScripter.

	aScripter substep: 'Add Playground into a World tab' do: [ :aStep |
		aStep do
			label: 'Show Playground space';
			block: [ :aTabElement | 
				| aStencil |
				aStencil := self playgroundStencil.
				GtWorldUtility 
					showSpaceWithIcon: aStencil icon 
					title: aStencil name 
					with: aStencil 
					from: aTabElement ].
			
		aStep wait forEmptySpaceTaskQueue.
					
		aStep check
			label: 'Check Playground in a new tab';
			value: [ :anElement | anElement tabs tabs size ]
			equals: 2.
			
		aStep check 
			label: 'Check Playground tab label';
			value: [ :anElement | anElement tabs tabs second widget label asString ]
			equals: 'Playground'.

		aStep check 
			label: 'Check Playground tab selection';
			satisfies: [ :anElement | anElement tabs tabs second isSelected ]
			description: [ 'Playground tab must be selected' ].
	].

	^ aScripter syncContinue
]

{ #category : #'examples - coder' }
GtWorldByScripterExamples >> browsePackageInSecondPane [
	<gtExample>
	| aScripter |
	aScripter := self clickOnPackageEditableName.

	aScripter substep: 'Browse package from editable name' do: [ :aStep |
		aStep shortcut
			combination: BlKeyCombination primaryB;
			id: GtPackageCoderPackageNameId.
		
		aStep check
			label: 'Check we have two tools';
			value: [ :anElement | anElement pages size ]
			equals: [ 2 ];
			id: GtWorldTabGroupId;
			onBreadthFirstChildOfClass: GtPager.

	].

	^ aScripter syncContinue
]

{ #category : #'examples - coder' }
GtWorldByScripterExamples >> clickAgainOnPackageEditableNameInTheFirstPane [
	<gtExample>
	| aScripter |
	aScripter := self selectClassInSecondPane.

	aScripter substep: 'Select the first pane with package' do: [ :aStep |
		aStep click
			label: 'Click on a package editable name';
			id: GtWorldTabGroupId;
			onBreadthFirstChildOfClass: GtPager;
			onChildFromBlock: [ :aPager | aPager pages first widget ];
			onBreadthFirstChildOfClass: GtPackageCoderElement;
			id: GtPackageCoderPackageNameId.
			
		aStep do pulse.
		
		aStep check
			label: 'Check World tab label with package name';
			value: [ :anElement | anElement tabs tabs second widget label asString ]
			equals: [ aScripter userData at: #tabLabel ].

	].

	^ aScripter syncContinue
]

{ #category : #'examples - coder' }
GtWorldByScripterExamples >> clickOnPackageEditableName [
	<gtExample>
	| aScripter |
	aScripter := self selectPackageInCoder.

	aScripter substep: 'Select package editable name' do: [ :aStep |
		aStep click
			label: 'Click on a package editable name';
			id: GtWorldTabGroupId;
			onBreadthFirstChildOfClass: GtPackageCoderElement;
			id: GtPackageCoderPackageNameId.
		
		aStep check
			label: 'Check World tab label';
			value: [ :anElement | anElement text asString ]
			equals: [ aScripter model name ];
			id: GtWorldTabGroupId;
			onBreadthFirstChildOfClass: GtPackageCoderElement;
			id: GtPackageCoderPackageNameId.

	].

	^ aScripter syncContinue
]

{ #category : #'examples - coder' }
GtWorldByScripterExamples >> clickOnWorldHomeCoderIcon [
	<gtExample>
	| aScripter |
	aScripter := self worldElementInScripter.

	aScripter substep: 'Click on World Home Coder button' do: [ :aStep |
		aStep click
			label: 'Click on Coder button';
			id: GtHomeCoderButtonId.
			
		aStep check
			label: 'Check Coder in a new tab';
			value: [ :anElement | anElement tabs tabs size ]
			equals: 2.
			
		aStep check 
			label: 'Check Coder tab label';
			value: [ :anElement | anElement tabs tabs second widget label asString ]
			equals: 'Coder'.

		aStep check 
			label: 'Check Coder tab selection';
			satisfies: [ :anElement | anElement tabs tabs second isSelected ]
			description: [ 'Coder tab must be selected' ].
	].

	^ aScripter syncContinue
]

{ #category : #'examples - world' }
GtWorldByScripterExamples >> coderStencil [
	<gtExample>
	^ GtCoderStencil new
]

{ #category : #'examples - playground' }
GtWorldByScripterExamples >> executePlaygroundSnippet [
	<gtExample>
	| aScripter |
	aScripter := self typeSnippetInPlayground.

	aScripter substep: 'Execute Playground snippet' do: [ :aStep |
			
		aStep shortcut
			combination: BlKeyCombination primaryG;
			id: GtWorldTabGroupId;
			onBreadthFirstChildOfClass: GtPager;
			onChildFromBlock: [ :aPager | aPager pages first widget ];
			onBreadthFirstChildOfClass: GtSourceCoderEditorElement.	
		
		aStep check
			label: 'Check we have two tools';
			value: [ :anElement | anElement pages size ]
			equals: [ 2 ];
			id: GtWorldTabGroupId;
			onBreadthFirstChildOfClass: GtPager.
	
	].

	^ aScripter syncContinue
]

{ #category : #'examples - playground' }
GtWorldByScripterExamples >> playgroundStencil [
	<gtExample>
	^ GtPlaygroundStencil new 
]

{ #category : #'examples - coder' }
GtWorldByScripterExamples >> selectClassInSecondPane [
	<gtExample>
	| aScripter |
	aScripter := self browsePackageInSecondPane.

	aScripter substep: 'Select class in second pane' do: [ :aStep |
		aStep click
			id: GtWorldTabGroupId;
			onBreadthFirstChildOfClass: GtPager;
			onChildFromBlock: [ :aPager | aPager pages second widget ];
			onBreadthFirstChildOfClass: GtPackageCoderElement;
			onBreadthFirstChildOfClass: GtClassesElement;
			onChildOfClass: BrSimpleList;
			onChildOfClass: BrInfiniteListElement;
			onChildAt: 1.
		
		aStep do
			label: 'Store expected class name';
			block: [ :anElement | 
				| aClass |
				anElement navigationModel selectedClassDo: [ :theClass | 
					aClass := theClass ].
				self 
					assert: aClass isNotNil
					description: 'Second pane must have a class selected'.
				aScripter userData at: #secondPaneModel put: aClass.
				aScripter userData at: #secondPaneTabLabel put: anElement shortTitle asString ];
			id: GtWorldTabGroupId;
			onBreadthFirstChildOfClass: GtPager;
			onChildFromBlock: [ :aPager | aPager pages second widget ];
			onBreadthFirstChildOfClass: GtCoder.

		aStep check
			label: 'Check World tab label with class name';
			value: [ :anElement | anElement tabs tabs second widget label asString ]
			equals: [ aScripter userData at: #secondPaneTabLabel ].
			
		aStep click
			label: 'Click on the second Coder';
			id: GtWorldTabGroupId;
			onBreadthFirstChildOfClass: GtPager;
			onChildFromBlock: [ :aPager | aPager pages second widget ];
			onBreadthFirstChildOfClass: GtBehaviorCoderElement;
			id: GtBehaviorCoderBehaviorNameId.

		aStep check
			label: 'Check World tab label with class name';
			value: [ :anElement | anElement tabs tabs second widget label asString ]
			equals: [ aScripter userData at: #secondPaneTabLabel ]
	].

	^ aScripter syncContinue
]

{ #category : #'examples - coder' }
GtWorldByScripterExamples >> selectPackageInCoder [
	<gtExample>
	| aScripter |
	aScripter := self addCoderIntoTabElement.

	aScripter substep: 'Select package' do: [ :aStep |
		aStep click
			label: 'Click on a package item';
			id: GtWorldTabGroupId;
			onBreadthFirstChildOfClass: GtPackagesCoderElement;
			onBreadthFirstChildOfClass: BrSimpleList;
			onChildOfClass: BrInfiniteListElement;
			onChildAt: 1.
			
		aStep do
			label: 'Store expected package name';
			block: [ :anElement | 
				anElement navigationModel selectedPackageDo: [ :aPackage | 
					aScripter model: aPackage ].
				self 
					assert: aScripter model isNotNil 
					description: 'Scripter model must be a package, but is nil'.
				aScripter userData at: #tabLabel put: anElement shortTitle asString ];
			id: GtWorldTabGroupId;
			onBreadthFirstChildOfClass: GtCoder.
						
		aStep check
			label: 'Check World tab label';
			value: [ :anElement | anElement tabs tabs second widget label asString ]
			equals: [ aScripter userData at: #tabLabel ]
	].

	^ aScripter syncContinue
]

{ #category : #'examples - world' }
GtWorldByScripterExamples >> tabElementInScripter [
	<gtExample>
	| aScripter |
	aScripter := self scripter.
	aScripter element: GtWorldTabElement new.
	aScripter wait forEmptySpaceTaskQueue.
	^ aScripter syncContinue
]

{ #category : #'examples - playground' }
GtWorldByScripterExamples >> typeSnippetInPlayground [
	<gtExample>
	| aScripter |
	aScripter := self addPlaygroundIntoTabElement.

	aScripter substep: 'Type Playground snippet' do: [ :aStep |
			
		aStep click
			id: GtWorldTabGroupId;
			onBreadthFirstChildOfClass: GtPager;
			onChildFromBlock: [ :aPager | aPager pages first widget ];
			onBreadthFirstChildOfClass: GtSourceCoderEditorElement.
			
		aStep type
			text: '42';
			id: GtWorldTabGroupId;
			onBreadthFirstChildOfClass: GtPager;
			onChildFromBlock: [ :aPager | aPager pages first widget ];
			onBreadthFirstChildOfClass: GtSourceCoderEditorElement.
			
		aStep check 
			label: 'Check Playground content';
			value: [ :anElement | anElement text asString ]
			equals: '42';
			onBreadthFirstChildOfClass: GtPager;
			onChildFromBlock: [ :aPager | aPager pages first widget ];
			onBreadthFirstChildOfClass: GtSourceCoderEditorElement.
			
	].

	^ aScripter syncContinue
]

{ #category : #'examples - world' }
GtWorldByScripterExamples >> worldElementInScripter [
	<gtExample>
	| aScripter |
	aScripter := self scripter.
	aScripter element: GtWorldElement new.
	aScripter wait forEmptySpaceTaskQueue.
	^ aScripter syncContinue
]
