Class {
	#name : #GtPackageDependencyStatus,
	#superclass : #Object,
	#instVars : [
		'package',
		'dependencyPackage',
		'dependencies',
		'codeStatus',
		'baselineStatuses'
	],
	#category : #'GToolkit-DependencyAnalyzer-Status'
}

{ #category : #accessing }
GtPackageDependencyStatus >> amountOfDependencies [
	^ dependencies size
]

{ #category : #accessing }
GtPackageDependencyStatus >> baselineStatusLabel [
	^ String streamContents: [ :aStream |
		baselineStatuses
			ifEmpty: [ aStream nextPutAll: 'Unknown' ]
			ifNotEmpty: [ :theDependencies |
				theDependencies
					do: [ :eachDependency | aStream nextPutAll: eachDependency statusLabel ]
					separatedBy: [ aStream nextPutAll: ', ' ] ] ]
]

{ #category : #accessing }
GtPackageDependencyStatus >> baselineStatuses [
	^ baselineStatuses
]

{ #category : #'api - statuses' }
GtPackageDependencyStatus >> codeMustNotDepend [
	codeStatus := GtPackageCodeDependencyMustNotDepend new
]

{ #category : #'api - statuses' }
GtPackageDependencyStatus >> codeNoLongerDependes [
	codeStatus := GtPackageCodeDependencyNoLongerDepends new
]

{ #category : #'api - statuses' }
GtPackageDependencyStatus >> codeOkay [
	codeStatus := GtPackageCodeDependencyOkay new
]

{ #category : #'api - statuses' }
GtPackageDependencyStatus >> codeShouldNotDepend [
	codeStatus := GtPackageCodeDependencyShouldNotDepend new
]

{ #category : #accessing }
GtPackageDependencyStatus >> dependencies [
	^ dependencies
]

{ #category : #initialization }
GtPackageDependencyStatus >> dependencies: anObject [

	dependencies := anObject
]

{ #category : #accessing }
GtPackageDependencyStatus >> dependencyPackage [

	^ dependencyPackage
]

{ #category : #initialization }
GtPackageDependencyStatus >> dependencyPackage: anObject [

	dependencyPackage := anObject
]

{ #category : #accessing }
GtPackageDependencyStatus >> dependencyPackageName [
	^ dependencyPackage name
]

{ #category : #'api - statuses' }
GtPackageDependencyStatus >> explicitBaselines: aCollectionOfBaselines [
	baselineStatuses add: (GtPackageBaselineExplicitlyDepends new baselines: aCollectionOfBaselines)
]

{ #category : #'gt - extensions' }
GtPackageDependencyStatus >> gtDependenciesFor: aView [
	<gtView>

	^ aView list
		title: 'Dependencies';
		priority: 6;
		items: [ dependencies asArray ]
]

{ #category : #printing }
GtPackageDependencyStatus >> gtDisplayText [	
	^ self printString asRopedText foreground: self statusColor
]

{ #category : #'gt - extensions' }
GtPackageDependencyStatus >> gtOverviewFor: aView [
	<gtView>

	^ aView explicit
		title: 'Overview';
		priority: 5;
		stencil: [ GtPharoPackageDependencyElement new packageDependency: self ]
]

{ #category : #'api - statuses' }
GtPackageDependencyStatus >> implicitBaselines: aCollectionOfBaselines [
	| theBaselines |

	theBaselines := baselineStatuses
		detect: [ :eachDependency | eachDependency isKindOf: GtPackageBaselineExplicitlyDepends ]
		ifFound: [ :anExplicitDependency | aCollectionOfBaselines copyWithoutAll: anExplicitDependency baselines ]
		ifNone: [ aCollectionOfBaselines ].
		
	theBaselines
		ifEmpty: [ ^ self ].

	baselineStatuses add: (GtPackageBaselineImplicitlyDepends new baselines: theBaselines)
]

{ #category : #initialization }
GtPackageDependencyStatus >> initialize [
	super initialize.
	
	baselineStatuses := OrderedCollection new.
	codeStatus := GtPackageCodeDependencyUnknown new
]

{ #category : #testing }
GtPackageDependencyStatus >> isDefinedByBaseline [
	^ baselineStatuses notEmpty
]

{ #category : #testing }
GtPackageDependencyStatus >> isOkay [
	^ codeStatus isOkayOrUnknown and: [ self isDefinedByBaseline ]
]

{ #category : #accessing }
GtPackageDependencyStatus >> package [

	^ package
]

{ #category : #initialization }
GtPackageDependencyStatus >> package: anObject [

	package := anObject
]

{ #category : #accessing }
GtPackageDependencyStatus >> packageName [
	^ package name
]

{ #category : #'api - statuses' }
GtPackageDependencyStatus >> preloadedBaselines: aCollectionOfBaselines [
	baselineStatuses add: (GtPackageBaselineVirtuallyDepends new baselines: aCollectionOfBaselines)
]

{ #category : #printing }
GtPackageDependencyStatus >> printOn: aStream [
	"Append a sequence of characters to aStream that identify the receiver."
	aStream
		print: package name;
		nextPutAll: ' depends on ';
		print: dependencyPackage name;
		space;
		nextPut: $(;
		nextPutAll: self statusLabel;
		nextPut: $)
]

{ #category : #'api - statuses' }
GtPackageDependencyStatus >> statusColor [
	codeStatus isOkayOrUnknown
		ifFalse: [ ^ codeStatus statusColor ].
	
	"code status is okay or unknown"
	self isDefinedByBaseline
		ifTrue: [ ^ baselineStatuses first statusColor ].
		
	"not defined any baseline"
	^ Color red darker
]

{ #category : #'api - statuses' }
GtPackageDependencyStatus >> statusLabel [
	codeStatus isOkayOrUnknown
		ifFalse: [ ^ codeStatus statusLabel ].

	"code status is okay or unknown"
	self isDefinedByBaseline
		ifTrue: [ ^ 'Defined in baseline', (codeStatus isOkay ifTrue: [ ' and ', codeStatus statusLabel ] ifFalse: [ '' ]) ].

	^ 'Undefined in baseline'
]
