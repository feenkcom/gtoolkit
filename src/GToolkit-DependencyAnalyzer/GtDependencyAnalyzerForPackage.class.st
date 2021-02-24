Class {
	#name : #GtDependencyAnalyzerForPackage,
	#superclass : #Object,
	#instVars : [
		'package',
		'preloadedBaselines',
		'definingBaselines',
		'packageDependencies'
	],
	#category : #'GToolkit-DependencyAnalyzer'
}

{ #category : #dependencies }
GtDependencyAnalyzerForPackage class >> baselinesForPackage: aPackageOrName [
	<return: #Collection of: #'BaselineOf class'>
	| aPackageName |

	aPackageName := aPackageOrName isString
		ifTrue: [ aPackageOrName ]
		ifFalse: [ aPackageOrName name ].

	^ BaselineOf allSubclasses select: [ :eachBaseline | eachBaseline allPackageNames includes: aPackageName ]
]

{ #category : #dependencies }
GtDependencyAnalyzerForPackage class >> packageDependenciesOf: aPackage [
	<return: #Set of: #RPackage>

	^ aPackage gtDependencies collect: [ :each | each toPackage ]
]

{ #category : #querying }
GtDependencyAnalyzerForPackage class >> packageNamed: aPackageName [
	^ self new package: aPackageName asPackage
]

{ #category : #comparing }
GtDependencyAnalyzerForPackage >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ package = anObject package
]

{ #category : #private }
GtDependencyAnalyzerForPackage >> computeDefiningBaselinesWithContext: aContext [
	| thePackagesFromBaseline |

	thePackagesFromBaseline := (self class baselinesForPackage: self package)
		collect: [ :eachBaseline |
			aContext
				package: self name
				fromBaseline: (GtDependencyAnalyzerForBaseline new baseline: eachBaseline) ] as: Array.
			
	thePackagesFromBaseline do: [ :eachPackage | eachPackage preloadedBaselines: self preloadedBaselines ].
	^ thePackagesFromBaseline
]

{ #category : #private }
GtDependencyAnalyzerForPackage >> computePackageDependencies [
	^ (self class packageDependenciesOf: self package)
		collect: [ :eachPackage | GtDependencyAnalyzerForPackage new package: eachPackage ] as: Array
]

{ #category : #dependencies }
GtDependencyAnalyzerForPackage >> definingBaselinesWithContext: aContext [
	^ definingBaselines ifNil: [ definingBaselines := self computeDefiningBaselinesWithContext: aContext ]
]

{ #category : #'gt-extensions' }
GtDependencyAnalyzerForPackage >> gtDefiningBaselinesFor: aView [
	<gtView>
	
	^ aView list
		title: 'Defining baseline';
		priority: 11;
		items: [ self definingBaselinesWithContext: GtDependencyAnalyzerContext new ]
]

{ #category : #'gt-extensions' }
GtDependencyAnalyzerForPackage >> gtIssuesFor: aView [
	<gtView>
	
	^ aView list
		title: 'Issues';
		priority: 5;
		items: [ self issuesWithContext: GtDependencyAnalyzerContext new ];
		itemText: [ :each | each gtDisplayString ]
]

{ #category : #'gt-extensions' }
GtDependencyAnalyzerForPackage >> gtPackageDependenciesFor: aView [
	<gtView>
	
	^ aView list
		title: 'Package dependencies';
		priority: 10;
		items: [ self packageDependencies sorted: [ :a :b | a package name < b package name ] ];
		itemText: [ :each | each package name ]
]

{ #category : #'gt-extensions' }
GtDependencyAnalyzerForPackage >> gtPreloadedBaselinesFor: aView [
	<gtView>
	preloadedBaselines ifNil: [ ^ aView empty ].
	^ aView list
		title: 'Preloaded baselines';
		items: [ self preloadedBaselines asOrderedCollection ]
]

{ #category : #comparing }
GtDependencyAnalyzerForPackage >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ package hash
]

{ #category : #initialization }
GtDependencyAnalyzerForPackage >> initialize [
	super initialize.
	
	preloadedBaselines := #()
]

{ #category : #dependencies }
GtDependencyAnalyzerForPackage >> issuesWithContext: aContext [
	| thePackageInBaselines |
	
	thePackageInBaselines := self definingBaselinesWithContext: aContext.
	thePackageInBaselines
		ifEmpty: [ ^ { GtDependencyAnalyzerPackageNotAssignedToBaselineIssue new package: self } ].
		
	thePackageInBaselines size > 1
		ifTrue: [ ^ {
			GtDependencyAnalyzerPackageIsDefinedInMultipleBaselinesIssue new
				package: self;
				packagesInBaseline: thePackageInBaselines } ].
	
	^ thePackageInBaselines anyOne issuesWithContext: aContext
]

{ #category : #accessing }
GtDependencyAnalyzerForPackage >> name [
	^ self package name
]

{ #category : #accessing }
GtDependencyAnalyzerForPackage >> package [
	^ package
]

{ #category : #accessing }
GtDependencyAnalyzerForPackage >> package: aPackage [
	package := aPackage
]

{ #category : #dependencies }
GtDependencyAnalyzerForPackage >> packageDependencies [
	^ packageDependencies ifNil: [ packageDependencies := self computePackageDependencies ]
]

{ #category : #accessing }
GtDependencyAnalyzerForPackage >> preloadedBaselines [
	^ preloadedBaselines
]

{ #category : #accessing }
GtDependencyAnalyzerForPackage >> preloadedBaselines: anObject [
	preloadedBaselines := anObject
]

{ #category : #printing }
GtDependencyAnalyzerForPackage >> printOn: aStream [
	aStream print: self package
]
