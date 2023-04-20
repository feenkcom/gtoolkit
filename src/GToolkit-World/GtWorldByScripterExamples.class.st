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
					from: aTabElement ];
			play.
			
		aStep check
			label: 'Check Coder in a new tab';
			value: [ :anElement | anElement tabs tabs size ] equals: 2;
			play.
			
		aStep check 
			label: 'Check Coder tab label';
			value: [ :anElement | anElement tabs tabs second widget label asString ]
				equals: 'Coder';
			play.

		aStep check 
			label: 'Check Coder tab selection';
			satisfies: [ :anElement | anElement tabs tabs second isSelected ]
				description: [ 'Coder tab must be selected' ];
			play ].

	^ aScripter
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
	aScripter shortcut
		combination: BlKeyCombination primaryB;
		id: GtPackageCoderPackageNameId;
		play.
	
	aScripter check
		label: 'Check we have two tools';
		// GtPager;
		value: [ :anElement | anElement pages size ] equals: [ 2 ];
		play.

	^ aScripter
]

{ #category : #'examples - read-only coders' }
GtWorldByScripterExamples >> cannotClickOnCoderIssue [
	"See [feenkcom/gtoolkit#3200](https://github.com/feenkcom/gtoolkit/issues/3200)"
	<gtExample>
	<noTest>
	| aScripter |
	aScripter := self executePlaygroundSnippet.

	aScripter
		substeps: 'Display method coder in Meta'
		do: [ :aStep | 
			aStep click
				label: 'Select Meta tab';
				// (GtPagerPageElementId indexed: 2);
				// GtInspector;
				// GtPhlowCompositeViewElementId;
				// #tabbar;
				onChildFromBlock: [ :anElement | anElement children detect: [ :each | each label asString = 'Meta' ] ];
				play.

			aStep click
				label: 'Expand the first method';
				// (GtPagerPageElementId indexed: 2);
				// GtCoder;
				// (GtSourceCoderId indexed: 1);
				play.
				
			aStep assert
				label: 'Assert a method coder is expanded';
				value: [ :anElement | anElement isExpanded ] equals: [ true ];
				// (GtPagerPageElementId indexed: 2);
				// GtCoder;
				// (GtSourceCoderId indexed: 1);
				play ].

	aScripter
		substeps: 'Display Integer view'
		do: [ :aStep | 
			aStep click
				label: 'Select Integer tab';
				// (GtPagerPageElementId indexed: 2);
				// GtInspector;
				// GtPhlowCompositeViewElementId;
				// #tabbar;
				onChildFromBlock: [ :aCollection |
					| aResult |
					aResult := aCollection
						collect: [ :anElement | 
							anElement children
								detect: [ :each | each label asString = 'Integer' ]
								ifNone: [ nil ] ]
						thenReject: #isNil.
					self assert: aResult size equals: 1.
					aResult anyOne ];
				play.
				
			aStep click
				label: 'Select an Integer detail';
				flag: 'This is actually a bug. We should be able just do double click';
				// (GtPagerPageElementId indexed: 2);
				// GtInspector;
				// (GtPhlowColumnedListId);
				// #scrollable;
				onChildAt: 1;
				play.
				
			aStep doubleClick
				label: 'Spawn an Integer detail';
				// (GtPagerPageElementId indexed: 2);
				// GtInspector;
				// (GtPhlowColumnedListId);
				// #scrollable;
				onChildAt: 1;
				play ].
				
	aScripter
		substeps: 'Display again the method coder in Meta'
		do: [ :aStep | 
			aStep click
				label: 'Select Meta tab';
				// (GtPagerPageElementId indexed: 2);
				// GtInspector;
				// GtPhlowCompositeViewElementId;
				// #tabbar;
				onChildFromBlock: [ :anElement | anElement children detect: [ :each | each label asString = 'Meta' ] ];
				play.

			aStep click
				label: 'Collapse the first method';
				// (GtPagerPageElementId indexed: 2);
				// GtCoder;
				// (GtSourceCoderId indexed: 1);
				// #sidebar;
				play.
				
			aStep assert
				label: 'Assert a method coder is collapsed';
				value: [ :anElement | anElement isExpanded ] equals: [ false ];
				// (GtPagerPageElementId indexed: 2);
				// GtCoder;
				// (GtSourceCoderId indexed: 1);
				play ].

	^ aScripter
]

{ #category : #'examples - coder' }
GtWorldByScripterExamples >> clickAgainOnPackageEditableNameInTheFirstPane [
	<gtExample>
	| aScripter |

	aScripter := self selectClassInSecondPane.
	aScripter click
		label: 'Click on a package editable name';
		id: GtPagerPageElementId index: 1;
		id: GtPackageCoderPackageNameId;
		play.
	
	aScripter check
		label: 'Check World tab label with package name';
		value: [ :anElement | anElement tabs tabs second widget label asString ]
		equals: [ aScripter userData at: #tabLabel ];
		play.

	^ aScripter
]

{ #category : #'examples - playground' }
GtWorldByScripterExamples >> clickBackOnPlaygroundInTheFirstPane [
	<gtExample>
	| aScripter |
	aScripter := self clickOnInspectorInTheSecondPane.

	aScripter substep: 'Click on Playground' do: [ :aStep |
		
		aStep click
			onBreadthFirstChildOfClass: GtPager;
			onChildFromBlock: [ :aPager | aPager pages first widget ];
			onBreadthFirstChildOfClass: GtSourceCoderEditorElement.
		
		aStep check 
			label: 'Check Playground tab label';
			value: [ :anElement | anElement tabs tabs second widget label asString ]
			equals: 'Playground'.
	].

	^ aScripter syncContinue
]

{ #category : #'examples - playground' }
GtWorldByScripterExamples >> clickOnInspectorInTheSecondPane [
	<gtExample>
	| aScripter |
	aScripter := self executePlaygroundSnippet.

	aScripter substep: 'Click on Inspector' do: [ :aStep |
			
		aStep click
			onBreadthFirstChildOfClass: GtPager;
			onChildFromBlock: [ :aPager | aPager pages second widget ];
			onBreadthFirstChildOfClass: GtInspector.	
		
		aStep check 
			label: 'Check Inspector tab label';
			value: [ :anElement | anElement tabs tabs second widget label asString ]
			equals: [ GtPhlowLabelBuilder new object: 42; build ].	
	].

	^ aScripter syncContinue
]

{ #category : #'examples - coder' }
GtWorldByScripterExamples >> clickOnPackageEditableName [
	<gtExample>
	| aScripter |

	aScripter := self selectPackageInCoder.
	aScripter click
		label: 'Click on a package editable name';
		id: GtPackageCoderPackageNameId;
		play.

	aScripter check
		label: 'Check World tab label';
		id: GtPackageCoderPackageNameId;
		value: [ :anElement | anElement text asString ] equals: [ aScripter model name ];
		play.

	^ aScripter
]

{ #category : #'examples - coder' }
GtWorldByScripterExamples >> clickOnPackageEditableNameInSecondPane [
	<gtExample>
	| aScripter |

	aScripter := self browsePackageInSecondPane.
	aScripter substep: 'Select package editable name in the second pane' do: [ :aStep |
		aStep click
			label: 'Click on a package editable name';
			id: GtPagerPageElementId index: 2;
			id: GtPackageCoderPackageNameId;
			play.
		
		self 
			setupExpectedTabLabel: [ :aNavigationModel | aNavigationModel selectedPackage ] 
			at: 2 
			step: aStep 
			scripter: aScripter.
		
		aStep check
			label: 'Check World tab label with class name';
			value: [ :anElement | anElement tabs tabs second widget label asString ]
				equals: [ aScripter userData at: (self paneTabLabelKeyAt: 2) ];
			play	].

	^ aScripter
]

{ #category : #'examples - coder' }
GtWorldByScripterExamples >> clickOnWorldHomeCoderIcon [
	<gtExample>
	| aScripter |

	aScripter := self worldElementInScripter.
	aScripter substep: 'Click on World Home Coder button' do: [ :aStep |
		aStep click
			label: 'Click on Coder button';
			id: GtHomeCoderButtonId;
			play.
			
		aStep check
			label: 'Check Coder in a new tab';
			value: [ :anElement | anElement tabs tabs size ] equals: 2;
			play.
			
		aStep check 
			label: 'Check Coder tab label';
			value: [ :anElement | anElement tabs tabs second widget label asString ] equals: 'Coder';
			play.

		aStep check 
			label: 'Check Coder tab selection';
			satisfies: [ :anElement | anElement tabs tabs second isSelected ]
				description: [ 'Coder tab must be selected' ];
			play ].

	^ aScripter
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

{ #category : #'examples - coder' }
GtWorldByScripterExamples >> paneModelKeyAt: aPaneIndex [
	^ 'paneModelAt', aPaneIndex asString
]

{ #category : #'examples - coder' }
GtWorldByScripterExamples >> paneTabLabelKeyAt: aPaneIndex [
	^ 'paneTabLabelAt', aPaneIndex asString
]

{ #category : #'examples - playground' }
GtWorldByScripterExamples >> playgroundStencil [
	<gtExample>
	^ GtPlaygroundStencil new 
]

{ #category : #'examples - coder' }
GtWorldByScripterExamples >> searchAndBrowseBlElementZIndexMethod [
	"Issue [feenkcom/gtoolkit#3168](https://github.com/feenkcom/gtoolkit/issues/3168)"

	<gtExample>
	| aScripter aLogger |
	aScripter := self worldElementInScripter.

	aScripter
		substep: 'Search BlElement>>#zIndex: using Spotter'
		do: [ :aStep | 
			aStep click
				label: 'Click on Spotter button';
				id: GtWorldSpotterSearchElementId;
				play.

			aStep type
				text: (BlElement >> #zIndex:) printString;
				play.

			aLogger := MemoryLogger startFor: GtPharoStreamingMethodsCoderElementSignal.
			aLogger name: '01 Browse method'.
			aScripter userData at: aLogger name put: aLogger.
				
			[ aStep keyPress
				label: 'Press return';
				key: BlKeyboardKey return;
				play ] ensure: [ aLogger stop ] ].
				
	aScripter assert 
		label: 'Assert ', (BlElement >> #zIndex:) printString, ' bounds in space';
		satisfies: [ :aMethodCoder | 
			aScripter space root boundsInSpace 
				containsRect: aMethodCoder boundsInSpace ];
		// GtCoder;
		// GtPharoStreamingMethodsCoderElement;
		/ GtPharoStreamingMethodsCoderListId;
		/ #scrollable;
		onChildFromBlock: [ :anInfiniteList |
			anInfiniteList children detect: [ :aMethodCoder | 
				aMethodCoder coderViewModel behavior = BlElement and: [
					aMethodCoder coderViewModel selector = #zIndex: ] ] ];
		play.
		
	aScripter assert 
		label: 'Assert ', (BlElement >> #zIndex:) printString, ' bounds in parent';
		satisfies: [ :aMethodCoder | 
			aMethodCoder parent boundsInSpace
				containsRect: aMethodCoder boundsInSpace ];
		// GtCoder;
		// GtPharoStreamingMethodsCoderElement;
		/ GtPharoStreamingMethodsCoderListId;
		/ #scrollable;
		onChildFromBlock: [ :anInfiniteList |
			anInfiniteList children detect: [ :aMethodCoder | 
				aMethodCoder coderViewModel behavior = BlElement and: [
					aMethodCoder coderViewModel selector = #zIndex: ] ] ];
		play.

	^ aScripter
]

{ #category : #'examples - coder' }
GtWorldByScripterExamples >> selectClassInSecondPane [
	<gtExample>
	| aScripter |

	aScripter := self clickOnPackageEditableNameInSecondPane.
	aScripter substep: 'Select class in second pane' do: [ :aStep |
		aStep click
			id: GtWorldTabGroupId;
			onBreadthFirstChildOfClass: GtPager;
			onChildFromBlock: [ :aPager | aPager pages second widget ];
			onBreadthFirstChildOfClass: GtPharoPackageCoderElement;
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
			onBreadthFirstChildOfClass: GtPharoBehaviorCoderElement;
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

{ #category : #'examples - coder' }
GtWorldByScripterExamples >> setupExpectedTabLabel: aBlock at: aPaneIndex step: aStep scripter: aScripter [
	<gtExample>
	aStep do
		label: 'Store expected Coder model and tab label name';
		block: [ :aCoder | 
			| aModel |
			aModel := aBlock value: aCoder navigationModel.
			self 
				assert: aModel isNotNil
				description: 'Second pane must have a class selected'.
			aScripter userData 
				at: (self paneModelKeyAt: aPaneIndex) put: aModel;
				at: (self paneTabLabelKeyAt: aPaneIndex) put: aCoder shortTitle asString ];
		id: GtWorldTabGroupId;
		onBreadthFirstChildOfClass: GtPager;
		onChildFromBlock: [ :aPager | (aPager pages at: aPaneIndex) widget ];
		onBreadthFirstChildOfClass: GtCoder;
		play
]

{ #category : #'examples - world' }
GtWorldByScripterExamples >> tabElementInScripter [
	<gtExample>
	| aScripter |

	aScripter := self scripter.
	aScripter element: GtWorldTabElement new.

	^ aScripter
]

{ #category : #'examples - playground' }
GtWorldByScripterExamples >> typeSnippetInPlayground [
	<gtExample>
	| aScripter |
	aScripter := self addPlaygroundIntoTabElement.

	aScripter substep: 'Type Playground snippet' do: [ :aStep |	
		aStep click
			id: GtPagerPageElementId index: 1;
			id: GtSourceCoderEditorId;
			play.

		aStep type
			text: '42';
			id: GtPagerPageElementId index: 1;
			id: GtSourceCoderEditorId;
			play.

		aStep check 
			label: 'Check Playground content';
			id: GtPagerPageElementId index: 1;
			id: GtSourceCoderEditorId;
			value: [ :anElement | anElement text asString ]
				equals: '42';
			play ].

	^ aScripter
]

{ #category : #'examples - world' }
GtWorldByScripterExamples >> worldElementInScripter [
	<gtExample>
	| aScripter |
	aScripter := self scripter.
	aScripter element: GtWorldElement new.
	^ aScripter
]
