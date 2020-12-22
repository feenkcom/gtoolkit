Class {
	#name : #GtDependencyAnalyzerForBaselineOfProject,
	#superclass : #GtDependencyAnalyzerForBaseline,
	#instVars : [
		'baselineOfProject'
	],
	#category : #'GToolkit-DependencyAnalyzer'
}

{ #category : #accessing }
GtDependencyAnalyzerForBaselineOfProject >> baselineOfProject [
	^ baselineOfProject
]

{ #category : #accessing }
GtDependencyAnalyzerForBaselineOfProject >> baselineOfProject: anObject [
	baselineOfProject := anObject
]

{ #category : #dependencies }
GtDependencyAnalyzerForBaselineOfProject >> directlyDefinedPackagesWithContext: aGtDependencyAnalyzerContext [
	<return: #Array of: #GtDependencyAnalyzerForPackageFromBaseline>

	cachedDirectlyDefinedPackages
		ifNotNil: [ ^ cachedDirectlyDefinedPackages ].

	cachedDirectlyDefinedPackages := aGtDependencyAnalyzerContext
		visitBaseline: self
		during: [
			(self baselineOfProject loadPackageList
				select: [  :aPackageName | RPackageOrganizer default includesPackageNamed: aPackageName ]
				thenCollect: [ :aPackageName |
					aGtDependencyAnalyzerContext
						package: aPackageName
						fromBaseline: self ]) as: Array ].

	cachedDirectlyDefinedPackages do: [ :eachPackageFromBaseline | eachPackageFromBaseline preloadedBaselines: self preloadedBaselines ].

	^ cachedDirectlyDefinedPackages asArray
]
