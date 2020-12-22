Class {
	#name : #GtWorldByScripterExamples,
	#superclass : #Object,
	#traits : 'TBlDevScripterExamples',
	#classTraits : 'TBlDevScripterExamples classTrait',
	#category : #'GToolkit-World-Examples'
}

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
			equals: [ aScripter userData at: #secondPaneTabLabel ]
	].

	^ aScripter syncContinue
]

{ #category : #'examples - coder' }
GtWorldByScripterExamples >> selectPackageInCoder [
	<gtExample>
	| aScripter |
	aScripter := self clickOnWorldHomeCoderIcon.

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
GtWorldByScripterExamples >> worldElementInScripter [
	<gtExample>
	| aScripter |
	aScripter := self scripter.
	aScripter element: GtWorldElement new.
	aScripter wait forEmptySpaceTaskQueue.
	^ aScripter syncContinue
]
