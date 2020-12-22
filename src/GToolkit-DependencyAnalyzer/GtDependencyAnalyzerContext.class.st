Class {
	#name : #GtDependencyAnalyzerContext,
	#superclass : #Object,
	#instVars : [
		'visitedBaselines',
		'visitedPackages',
		'packageFromBaselineMap'
	],
	#category : #'GToolkit-DependencyAnalyzer'
}

{ #category : #initialization }
GtDependencyAnalyzerContext >> initialize [
	super initialize.
	
	visitedBaselines := Stack new.
	visitedPackages := Stack new.
	packageFromBaselineMap := Dictionary new
]

{ #category : #accessing }
GtDependencyAnalyzerContext >> package: aPackageName fromBaseline: aBaselineAnalyzer [
	^ packageFromBaselineMap
		at: (aBaselineAnalyzer -> aPackageName asSymbol)
		ifAbsentPut: [
			GtDependencyAnalyzerForPackageFromBaseline new
				forBaseline: aBaselineAnalyzer
				andPackage: (GtDependencyAnalyzerForPackage new package: aPackageName asPackage) ]
]

{ #category : #visiting }
GtDependencyAnalyzerContext >> visitBaseline: aBaseline during: aBlock [
	(visitedBaselines includes: aBaseline)
		ifTrue: [ self error: 'Circular dependency detected while visiting ', aBaseline name ].

	visitedBaselines push: aBaseline.
	^ aBlock ensure: [ visitedBaselines pop ]
]

{ #category : #visiting }
GtDependencyAnalyzerContext >> visitPackage: aPackage during: aBlock [
	(visitedPackages includes: aPackage)
		ifTrue: [
			| visitedPackagesCopy visitedBaselinesCopy |
			visitedPackagesCopy := visitedPackages copy.
			visitedBaselinesCopy := visitedBaselines copy.
			self error: 'Circular dependency detected while visiting ', aPackage name ].
	
	visitedPackages push: aPackage.
	^ aBlock ensure: [ visitedPackages pop ]
]
