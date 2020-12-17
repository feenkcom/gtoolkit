Class {
	#name : #GtBaselinesShouldProperlySpecifyDependencies,
	#superclass : #GtPharoConstraint,
	#category : #'GToolkit-Constraints'
}

{ #category : #private }
GtBaselinesShouldProperlySpecifyDependencies >> baselinesFor: aPackageOrName [
	| aPackageName |
	aPackageName := aPackageOrName isString
		ifTrue: [ aPackageOrName ]
		ifFalse: [ aPackageOrName name ].
	^ BaselineOf allSubclasses select: [ :eachBaseline | eachBaseline allPackageNames includes: aPackageName ]
]

{ #category : #private }
GtBaselinesShouldProperlySpecifyDependencies >> declaredPackagesOfBaseline: aBaselineClass [
	^ (aBaselineClass project version projects
		flatCollect: [ :eachProject | eachProject loadPackageList ]), aBaselineClass allPackageNames
]

{ #category : #accessing }
GtBaselinesShouldProperlySpecifyDependencies >> issues [
	"returns the facts that contradict the constraint"
	^ self packagesToAnalyse
		collect: [ :eachPackage | eachPackage -> (self undeclaredPackageDependenciesOf: eachPackage) ]
		thenSelect: [ :eachAssoc | eachAssoc value isNotEmpty ]
]

{ #category : #accessing }
GtBaselinesShouldProperlySpecifyDependencies >> name [
	^ 'Baselines should properly define project dependencies'
]

{ #category : #private }
GtBaselinesShouldProperlySpecifyDependencies >> packageDependencyNamesOf: aPackage [
	^ aPackage gtDependencies collect: [ :each | each toPackage name ]
]

{ #category : #accessing }
GtBaselinesShouldProperlySpecifyDependencies >> packagesToAnalyse [

	^ RPackage organizer packages select: [ :aPackage | 
		#('Brick' 'Bloc') anySatisfy: [ :prefix | aPackage name beginsWith: prefix ] ]
]

{ #category : #private }
GtBaselinesShouldProperlySpecifyDependencies >> undeclaredPackageDependenciesOf: aPackage [
	| packageDependencyNames packageBaseline declaredDependencies |

	packageBaseline := self baselinesFor: aPackage.
	packageBaseline isEmpty
		ifTrue: [ ^ 'No baseline found' ].
		
	packageBaseline size > 1
		ifTrue: [ ^ packageBaseline ].
	
	packageDependencyNames := self packageDependencyNamesOf: aPackage.

	declaredDependencies := self declaredPackagesOfBaseline: packageBaseline first.
		
	^ packageDependencyNames difference: declaredDependencies
]
