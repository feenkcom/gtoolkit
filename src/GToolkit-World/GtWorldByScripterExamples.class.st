Class {
	#name : #GtWorldByScripterExamples,
	#superclass : #Object,
	#traits : 'TBlDevScripterExamples',
	#classTraits : 'TBlDevScripterExamples classTrait',
	#category : #'GToolkit-World-Examples'
}

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
GtWorldByScripterExamples >> selectPackageInCoder [
	<gtExample>
	| aScripter |
	aScripter := self clickOnWorldHomeCoderIcon.

	aScripter substep: 'Click on package' do: [ :aStep |
		aStep click
			label: 'Click on Coder button';
			id: GtWorldTabGroupId;
			onBreadthFirstChildOfClass: GtPackagesCoderElement;
			onBreadthFirstChildOfClass: BrSimpleList;
			onChildOfClass: BrInfiniteListElement;
			onChildAt: 1.
			
		aStep do
			label: 'Store package name';
			block: [ :anElement | aScripter model: anElement packageCoder package name asString ];
			id: GtWorldTabGroupId;
			onBreadthFirstChildOfClass: GtPackageCoderElement.
						
		aStep check
			label: 'Check World Tab label';
			value: [ :anElement | anElement tabs tabs second widget label asString ]
			equals: [ 'Coder: ', aScripter model ]
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
