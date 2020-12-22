Class {
	#name : #GtDependencyAnalyzerPackageRequirement,
	#superclass : #Object,
	#instVars : [
		'packageFromBaseline'
	],
	#category : #'GToolkit-DependencyAnalyzer'
}

{ #category : #dependencies }
GtDependencyAnalyzerPackageRequirement >> directlyRequiredPackagesWithContext: aGtDependencyAnalyzerContext [
	<return: #Array of: #GtDependencyAnalyzerForPackageFromBaseline>

	^ self subclassResponsibility
]

{ #category : #'gt-extensions' }
GtDependencyAnalyzerPackageRequirement >> gtDirectlyDefinedPackagesFor: aView [
	<gtView>
	
	^ aView list
		title: 'Explicitly required packages';
		priority: 10;
		items: [
			GtDependencyAnalyzerContext new
				visitPackage: packageFromBaseline
				during: [
					(self directlyRequiredPackagesWithContext: GtDependencyAnalyzerContext new)
						sorted: [ :a :b | a name < b name ] ] ]
]

{ #category : #dependencies }
GtDependencyAnalyzerPackageRequirement >> indirectlyRequiredPackagesWithContext: aGtDependencyAnalyzerContext [
	^ self subclassResponsibility
]

{ #category : #accessing }
GtDependencyAnalyzerPackageRequirement >> packageFromBaseline [
	<return: #GtDependencyAnalyzerForPackageFromBaseline>

	^ packageFromBaseline
]

{ #category : #accessing }
GtDependencyAnalyzerPackageRequirement >> packageFromBaseline: aGtDependencyAnalyzerForPackageFromBaseline [
	packageFromBaseline := aGtDependencyAnalyzerForPackageFromBaseline
]

{ #category : #'as yet unclassified' }
GtDependencyAnalyzerPackageRequirement >> requiredBaseline [
	<return: #GtDependencyAnalyzerForBaseline>

	^ self subclassResponsibility
]
