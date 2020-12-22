Class {
	#name : #GtDependencyAnalyzerPackageBaselineRequirement,
	#superclass : #GtDependencyAnalyzerPackageRequirement,
	#instVars : [
		'requirementBaselineAnalyzer'
	],
	#category : #'GToolkit-DependencyAnalyzer'
}

{ #category : #dependencies }
GtDependencyAnalyzerPackageBaselineRequirement >> directlyRequiredPackagesWithContext: aGtDependencyAnalyzerContext [
	<return: #Array of: #GtDependencyAnalyzerForPackageFromBaseline>
	| explicitlyRequiredPackages |

	explicitlyRequiredPackages := requirementBaselineAnalyzer directlyDefinedPackagesWithContext: aGtDependencyAnalyzerContext.
	
	self
		assert: [ (explicitlyRequiredPackages includes: packageFromBaseline) not ]
		description: [ 'Package can not depend on itself ', packageFromBaseline printString ].
		
	^ explicitlyRequiredPackages
]

{ #category : #dependencies }
GtDependencyAnalyzerPackageBaselineRequirement >> indirectlyRequiredPackagesWithContext: aGtDependencyAnalyzerContext [
	<return: #Array of: #GtDependencyAnalyzerForPackageFromBaseline>
	| implicitlyRequiredPackages |
	
	implicitlyRequiredPackages := requirementBaselineAnalyzer indirectlyDefinedPackagesWithContext: aGtDependencyAnalyzerContext.
	
	self
		assert: [ (implicitlyRequiredPackages includes: packageFromBaseline) not ]
		description: [ 'Package can not depend on itself ', packageFromBaseline printString ].
		
	^ implicitlyRequiredPackages
]

{ #category : #printing }
GtDependencyAnalyzerPackageBaselineRequirement >> printOn: aStream [
	aStream print: self requirementBaselineAnalyzer
]

{ #category : #'as yet unclassified' }
GtDependencyAnalyzerPackageBaselineRequirement >> requiredBaseline [
	<return: #GtDependencyAnalyzerForBaseline>
	
	^ self requirementBaselineAnalyzer
]

{ #category : #accessing }
GtDependencyAnalyzerPackageBaselineRequirement >> requirementBaselineAnalyzer [
	^ requirementBaselineAnalyzer
]

{ #category : #accessing }
GtDependencyAnalyzerPackageBaselineRequirement >> requirementBaselineAnalyzer: anObject [
	requirementBaselineAnalyzer := anObject
]
