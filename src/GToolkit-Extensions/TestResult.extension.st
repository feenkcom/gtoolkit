Extension { #name : #TestResult }

{ #category : #'*GToolkit-Extensions' }
TestResult >> gtAllCompiledMethodsForTestCases: theTestCases [

	| aCollection |
	aCollection := OrderedCollection new.

	theTestCases do: [ :eachTestCase | 
		eachTestCase testCasesDo: [ :aTestCase | 
			aTestCase gtCompiledMethod ifNotNil: [ :aMethod | 
				(aCollection identityIncludes: aMethod) ifFalse: [ 
					aCollection add: aMethod ] ] ] ].

	aCollection sort: GtMethodsSortFunction new.

	^ aCollection
]

{ #category : #'*GToolkit-Extensions' }
TestResult >> gtErrorFor: aView [

	<gtView>
	self errorCount isZero ifTrue: [ ^ aView empty ].

	^ aView explicit
		  title: 'Errors';
		  priority: 4;
		  stencil: [ 
			  | aCollection aMethodsCoder aResult |
			  aCollection := self errors.
			  aResult := TestResult new errors: aCollection.
			  aMethodsCoder := GtPharoMethodsCoder forItems:
					       (self gtAllCompiledMethodsForTestCases: aCollection).
			  aMethodsCoder coders do: [ :eachCoder | eachCoder testCase result: aResult ].
			  aMethodsCoder ]
]

{ #category : #'*GToolkit-Extensions' }
TestResult >> gtFailuresFor: aView [

	<gtView>
	self failureCount isZero ifTrue: [ ^ aView empty ].

	^ aView explicit
		  title: 'Failures';
		  priority: 3;
		  stencil: [ 
			  | aCollection aMethodsCoder aResult |
			  aCollection := self failures.
			  aResult := TestResult new failures: aCollection.
			  aMethodsCoder := GtPharoMethodsCoder forItems:
					       (self gtAllCompiledMethodsForTestCases: aCollection).
			  aMethodsCoder coders do: [ :eachCoder | eachCoder testCase result: aResult ].
			  aMethodsCoder ]
]

{ #category : #'*GToolkit-Extensions' }
TestResult >> gtPassedFor: aView [

	<gtView>
	self passedCount isZero ifTrue: [ ^ aView empty ].

	^ aView explicit
		  title: 'Passed';
		  priority: 1;
		  stencil: [ 
			  | aCollection aMethodsCoder aResult |
			  aCollection := self passed.
			  aResult := TestResult new passed: aCollection.
			  aMethodsCoder := GtPharoMethodsCoder forItems:
					       (self gtAllCompiledMethodsForTestCases: aCollection).
			  aMethodsCoder coders do: [ :eachCoder | eachCoder testCase result: aResult ].
			  aMethodsCoder ]
]

{ #category : #'*GToolkit-Extensions' }
TestResult >> gtResultsFor: aView [

	<gtView>
	^ aView tree
		  title: 'Results';
		  priority: 0;
		  items: [ #( #passed #skipped #failures #errors ) ];
		  children: [ :anItem | 
		  	anItem isSymbol 
		  		ifTrue: [ self perform: anItem ]
		  		ifFalse: [ #() ] ];
		  expandAll;
		  send: [ :anItem | 
		  	anItem isSymbol 
		  		ifTrue: [ self perform: anItem ]
		  		ifFalse: [ anItem ] ]
]

{ #category : #'*GToolkit-Extensions' }
TestResult >> gtSkippedFor: aView [

	<gtView>
	self skippedCount isZero ifTrue: [ ^ aView empty ].

	^ aView explicit
		  title: 'Skipped';
		  priority: 2;
		  stencil: [ 
			  GtPharoMethodsCoder forItems:
					  (self gtAllCompiledMethodsForTestCases: self skipped) ]
]
