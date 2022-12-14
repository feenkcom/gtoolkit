Class {
	#name : #GtPharoPackageBaselineDependenciesConstraint,
	#superclass : #GtPharoConstraint,
	#category : #'GToolkit-Constraints'
}

{ #category : #'gt - extensions' }
GtPharoPackageBaselineDependenciesConstraint >> gtValidatedPackagesFor: aView [
	<gtView>
	
	^ aView list
		title: 'Validated packages';
		priority: 11;
		items: [ self packagesToValidate ]
]

{ #category : #accessing }
GtPharoPackageBaselineDependenciesConstraint >> issues [
	"returns the facts that contradict the constraint"
	
	^ Array streamContents: [ :aStream |
		RPackage organizer packageNames do: [ :eachPackageName | aStream nextPutAll: (self packageIssuesOf: eachPackageName) ] ]
]

{ #category : #accessing }
GtPharoPackageBaselineDependenciesConstraint >> name [ 
	^ 'Package dependencies must be correctly specified in the baseline'
]

{ #category : #'private - dependencies' }
GtPharoPackageBaselineDependenciesConstraint >> packageIssuesOf: aPackageName [
	| aPackage aPackageManifest |

	aPackage := aPackageName
			asPackageIfAbsent: [ ^ {'Package named {1} does not exist'
						format: {aPackageName asString printString}} ].

	aPackageManifest := aPackage packageManifestOrNil ifNil: [ ^ #() ].

	[ aPackageManifest shouldValidateBaseline ifFalse: [ ^ #() ] ]
		onDNU: #shouldValidateBaseline
		do: [ :ex | ^ #() ].

	^ aPackage gtDependenciesStatusByAnalyzer reject: [ :eachDependency | eachDependency isOkay ]
]

{ #category : #accessing }
GtPharoPackageBaselineDependenciesConstraint >> packagesToValidate [
	^ (Array streamContents: [ :aStream |
		RPackage organizer packageNames do: [ :eachPackageName |
			| eachPackage |
	
			eachPackage := eachPackageName asPackageIfAbsent: [
				self error: ('Package named {1} does not exist' format: { eachPackageName asString printString }) ].
			
			eachPackage packageManifestOrNil ifNotNil: [ :aPackageManifest |
				[ aPackageManifest shouldValidateBaseline ifTrue: [ aStream nextPut: eachPackage ] ]
					onDNU: #shouldValidateBaseline
					do: [ :ex | ]
			] ] ]) sorted: [ :a :b | a name < b name ]
]
