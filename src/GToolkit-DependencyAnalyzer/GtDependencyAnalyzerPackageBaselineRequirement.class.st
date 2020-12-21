Class {
	#name : #GtDependencyAnalyzerPackageBaselineRequirement,
	#superclass : #GtDependencyAnalyzerPackageRequirement,
	#instVars : [
		'requirementBaselineAnalyzer'
	],
	#category : #'GToolkit-DependencyAnalyzer'
}

{ #category : #dependencies }
GtDependencyAnalyzerPackageBaselineRequirement >> explicitlyRequiredPackagesWithContext: aGtDependencyAnalyzerContext [
	<return: #Array of: #GtDependencyAnalyzerForPackageFromBaseline>
	| explicitlyRequiredPackages |

	explicitlyRequiredPackages := requirementBaselineAnalyzer explicitlyDefinedPackagesWithContext: aGtDependencyAnalyzerContext.
	
	self
		assert: [ (explicitlyRequiredPackages includes: packageFromBaseline) not ]
		description: [ 'Package can not depend on itself ', packageFromBaseline printString ].
		
	^ explicitlyRequiredPackages
]

{ #category : #dependencies }
GtDependencyAnalyzerPackageBaselineRequirement >> implicitlyRequiredPackagesWithContext: aGtDependencyAnalyzerContext [
	<return: #Array of: #GtDependencyAnalyzerForPackageFromBaseline>
	| implicitlyRequiredPackages |
	
	implicitlyRequiredPackages := requirementBaselineAnalyzer implicitlyDefinedPackagesWithContext: aGtDependencyAnalyzerContext.
	
	self
		assert: [ (implicitlyRequiredPackages includes: packageFromBaseline) not ]
		description: [ 'Package can not depend on itself ', packageFromBaseline printString ].
		
	^ implicitlyRequiredPackages
]

{ #category : #printing }
GtDependencyAnalyzerPackageBaselineRequirement >> printOn: aStream [
	aStream print: self requirementBaselineAnalyzer
]

{ #category : #accessing }
GtDependencyAnalyzerPackageBaselineRequirement >> requirementBaselineAnalyzer [
	^ requirementBaselineAnalyzer
]

{ #category : #accessing }
GtDependencyAnalyzerPackageBaselineRequirement >> requirementBaselineAnalyzer: anObject [
	requirementBaselineAnalyzer := anObject
]
