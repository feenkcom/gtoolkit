Class {
	#name : #GtPackageDependencyStatuses,
	#superclass : #Object,
	#instVars : [
		'package',
		'dependencies',
		'packageBaselines'
	],
	#category : #'GToolkit-DependencyAnalyzer-Status'
}

{ #category : #accessing }
GtPackageDependencyStatuses >> dependencies [

	^ dependencies
]

{ #category : #accessing }
GtPackageDependencyStatuses >> dependencies: anObject [

	dependencies := anObject
]

{ #category : #'gt - extensions' }
GtPackageDependencyStatuses >> gtDependenciesFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Dependencies';
		priority: 2;
		items: [ dependencies ];
		column: 'Package'
			text: [ :eachDependencyStatus | 
				eachDependencyStatus dependencyPackageName asRopedText
					foreground: eachDependencyStatus statusColor ]
			weight: 0.5;
		column: 'Baseline'
			text: [ :eachDependencyStatus | 
				eachDependencyStatus baselineStatusLabel asRopedText ];
		column: 'Dependencies'
			text: [ :eachDependencyStatus | 
				eachDependencyStatus amountOfDependencies asRopedText
					foreground: eachDependencyStatus statusColor ]
			width: 100;
		column: 'Status'
			text: [ :eachDependencyStatus | 
				eachDependencyStatus statusLabel asRopedText
					foreground: eachDependencyStatus statusColor ]
			width: 220;
		actionButtonIcon: BrGlamorousVectorIcons refresh 
		tooltip: 'Update'
			action: [ :aButton :aTab |
				dependencies := package gtDependenciesStatusByAnalyzer.
				aTab viewContentElement phlow update ];
		actionButtonDo: [ :anAction |
			anAction
				icon: BrGlamorousVectorIcons accept;
				label: 'Include in baseline validation';
				action: [ self markAsShouldValidateBaseline ] ]
]

{ #category : #printing }
GtPackageDependencyStatuses >> gtDisplayAsArrayFor: aView [
	<gtView>
	^ aView textEditor
		title: 'Print as array';
		priority: 11;
		aptitude: BrGlamorousCodeEditorAptitude;
		text: [ String
				streamContents: [ :aStream | 
					aStream
						tab;
						nextPutAll: '^ ';
						nextPut: ${;
						cr.

					dependencies
						do: [ :each | 
							aStream
								tab;
								tab;
								print: each dependencyPackageName asString;
								nextPut: $.;
								cr ].
					aStream
						tab;
						nextPut: $} ] ]
]

{ #category : #private }
GtPackageDependencyStatuses >> markAsShouldNotValidateBaseline [
	package packageManifest class compile:
'shouldValidateBaseline
	^ false' classified: 'testing'.
]

{ #category : #private }
GtPackageDependencyStatuses >> markAsShouldValidateBaseline [
	package packageManifest class compile:
'shouldValidateBaseline
	^ true' classified: 'testing'.
]

{ #category : #accessing }
GtPackageDependencyStatuses >> package [

	^ package
]

{ #category : #accessing }
GtPackageDependencyStatuses >> package: anRPackage [
	package := anRPackage.
	packageBaselines := GtDependencyAnalyzerForPackage baselinesForPackage: package
]

{ #category : #printing }
GtPackageDependencyStatuses >> printOn: aStream [
	aStream
		print: dependencies size;
		space;
		nextPutAll: ' dependencies of ';
		nextPutAll: package name
]

{ #category : #private }
GtPackageDependencyStatuses >> shouldValidateBaseline [
	^ package packageManifestOrNil
		ifNil: [ ^ false ]
		ifNotNil: [ :aPackageManifest |
			[ aPackageManifest shouldValidateBaseline ]
					onDNU: #shouldValidateBaseline
					do: [ :ex | false ] ]
]
