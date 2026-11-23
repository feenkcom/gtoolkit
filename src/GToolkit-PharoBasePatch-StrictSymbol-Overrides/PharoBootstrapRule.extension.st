Extension { #name : #PharoBootstrapRule }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
PharoBootstrapRule >> basicCheck: aPackage [
	"The bootstrap package names are Strings, package names Symbols"
	<gtPharoPatch: #StrictComparison>

	(self bootstrapPackages includes: aPackage name asString) ifFalse: [ ^ false "Do not check" ].
	^ self newExternalDependencyExistFor: aPackage
]

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
PharoBootstrapRule >> newExternalDependencyExistFor: aPackage [
	"The dependencies are package names (Symbols), the bootstrap packages Strings: remove both kinds"
	<gtPharoPatch: #StrictComparison>
	"Check if there are new dependencies to a package outside this layer"

	^ ((self dependencyChecker dependenciesOf: aPackage name) difference: (self bootstrapPackages , (self bootstrapPackages collect: [ :each | each asSymbol ]))) isNotEmpty
]
