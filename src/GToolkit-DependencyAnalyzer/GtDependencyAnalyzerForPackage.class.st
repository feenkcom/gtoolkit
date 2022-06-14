Class {
	#name : #GtDependencyAnalyzerForPackage,
	#superclass : #Object,
	#instVars : [
		'package',
		'preloadedBaselines',
		'definingBaselines',
		'packageDependencies',
		'packageDependents'
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

{ #category : #dependencies }
GtDependencyAnalyzerForPackage class >> packageDependentsOf: aPackage [
	<return: #GtPharoAssociation>

	^ aPackage gtDependents
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
				fromBaseline: (aContext dependencyAnalyzerForBaseline: eachBaseline) ] as: Array.
			
	thePackagesFromBaseline do: [ :eachPackage | eachPackage preloadedBaselines: self preloadedBaselines ].
	^ thePackagesFromBaseline
]

{ #category : #private }
GtDependencyAnalyzerForPackage >> computePackageDependencies [
	^ (self class packageDependenciesOf: self package)
		collect: [ :eachPackage | GtDependencyAnalyzerForPackage new 
			package: eachPackage; 
			preloadedBaselines: self preloadedBaselines ] as: Array
]

{ #category : #private }
GtDependencyAnalyzerForPackage >> computePackageDependents [
	^ self class packageDependentsOf: self package
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
GtDependencyAnalyzerForPackage >> gtPackageDependentsFor: aView [

	<gtView>
	^ aView tree
			title: 'Package dependents';
			priority: 11;
			items: [ 
			  (self packageDependents groupedBy: [ :eachAssociation | 
					   eachAssociation from package]) associations sorted: [:a :b | a name < b name] ];
			children: [ :each | 
			  (each isKindOf: GtPharoAssociation)
				  ifTrue: [ #(  ) ]
				  ifFalse: [ 
					  (each isKindOf: Association)
						  ifTrue: [ 
							  each key = GtPharoClassReference
								  ifTrue: [ 
									  | aSorter |
									  aSorter := GtMethodsSortFunction new.
									  each value sorted: [ :a :b | 
											  aSorter
												  value: a referencingMethod
												  value: b referencingMethod ] ]
								  ifFalse: [ each value ] ]
						  ifFalse: [ #(  ) ] ] ];
			itemText: [ :each | 
			  (each isKindOf: Association)
				  ifTrue: [ each key name, ' (', each value size asString, ')' ]
				  ifFalse: [ each ] ];
			send: [:a | a isAssociation ifTrue: [ a value ] ifFalse: [a]]
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

{ #category : #dependencies }
GtDependencyAnalyzerForPackage >> packageDependents [
	^ packageDependents ifNil: [ packageDependents := self computePackageDependents ]
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
