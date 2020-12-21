Class {
	#name : #GtDependencyAnalyzerForPackage,
	#superclass : #Object,
	#instVars : [
		'package',
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
GtDependencyAnalyzerForPackage >> computeDefiningBaselines [
	^ (self class baselinesForPackage: self package)
		collect: [ :eachBaseline |
			GtDependencyAnalyzerForPackageFromBaseline new
				forBaseline: (GtDependencyAnalyzerForBaseline new baseline: eachBaseline)
				andPackage: self ] as: Array
]

{ #category : #private }
GtDependencyAnalyzerForPackage >> computePackageDependencies [
	^ (self class packageDependenciesOf: self package)
		collect: [ :eachPackage | GtDependencyAnalyzerForPackage new package: eachPackage ] as: Array
]

{ #category : #dependencies }
GtDependencyAnalyzerForPackage >> definingBaselines [
	^ definingBaselines ifNil: [ definingBaselines := self computeDefiningBaselines ]
]

{ #category : #'gt-extensions' }
GtDependencyAnalyzerForPackage >> gtDefiningBaselinesFor: aView [
	<gtView>
	
	^ aView list
		title: 'Defining baseline';
		priority: 10;
		items: [ self definingBaselines ]
]

{ #category : #'gt-extensions' }
GtDependencyAnalyzerForPackage >> gtPackageDependenciesFor: aView [
	<gtView>
	
	^ aView list
		title: 'Package dependencies';
		priority: 5;
		items: [ self packageDependencies sorted: [ :a :b | a package name < b package name ] ];
		itemText: [ :each | each package name ]
]

{ #category : #comparing }
GtDependencyAnalyzerForPackage >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ package hash
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

{ #category : #printing }
GtDependencyAnalyzerForPackage >> printOn: aStream [
	aStream print: self package
]
