Extension { #name : #RPackage }

{ #category : #'*GToolkit-DependencyAnalyzer' }
RPackage >> gtBehaviorReferences [
	"Return all behaviors referenced by behaviors in this package.
	This is opposite to #gtClassReferents"

	^ self gtMethodReferences flatCollectAsSet: [ :m | 
		m method gtReferencedBehaviors collect: [ :each | 
			GtPharoClassReference new 
				referencingMethod: m; 
				referencedClass: each ]]
]

{ #category : #'*GToolkit-DependencyAnalyzer' }
RPackage >> gtClassExtensions [
	^ self extensionMethods collect: [ :each | GtPharoClassExtension new extendingMethod: each ]
]

{ #category : #'*GToolkit-DependencyAnalyzer' }
RPackage >> gtClassReferences [
	"Return all classes referenced by classes in this package.
	This is opposite to #gtClassReferents"

	^ self gtMethodReferences flatCollectAsSet: [ :m | 
		m method gtReferencedClasses collect: [ :each | 
			GtPharoClassReference new 
				referencingMethod: m; 
				referencedClass: each ]]
]

{ #category : #'*GToolkit-DependencyAnalyzer' }
RPackage >> gtDeclaredMustNotDependOn [
	^ self packageManifestOrNil
		ifNil: [ nil ]
		ifNotNil: [ :aManifest |
			[ aManifest mustNotDependOn collect: [ :eachPackageName | eachPackageName asPackage ] ]
				onDNU: #mustNotDependOn
				do: [ :ex | nil ] ]
]

{ #category : #'*GToolkit-DependencyAnalyzer' }
RPackage >> gtDeclaredMustOnlyDependOn [
	^ self packageManifestOrNil
		ifNil: [ nil ]
		ifNotNil: [ :aManifest |
			[ aManifest mustOnlyDependOn collect: [ :eachPackageName | eachPackageName asPackage ] ]
				onDNU: #mustOnlyDependOn
				do: [ :ex | nil ] ]
]

{ #category : #'*GToolkit-DependencyAnalyzer' }
RPackage >> gtDeclaredShouldDependOn [
	^ self packageManifestOrNil
		ifNil: [ nil ]
		ifNotNil: [ :aManifest |
			[ aManifest shouldDependOn collect: [ :eachPackageName | eachPackageName asPackage ] ]
				onDNU: #shouldDependOn
				do: [ :ex | nil ] ]
]

{ #category : #'*GToolkit-DependencyAnalyzer' }
RPackage >> gtDependencies [
	| all |
	all := Set new.
	all addAll: self gtClassExtensions.
	all addAll: self gtInheritances.
	all addAll: self gtTraitUsages.
	all addAll: self gtBehaviorReferences.
	all addAll: self gtExtensionMethodReferences.
	^ all select: [ :each | each toPackage ~= self ]
]

{ #category : #'*GToolkit-DependencyAnalyzer' }
RPackage >> gtDependents [
	| all |
	all := Set new.
	all addAll: self gtIncomingClassExtensions.
	all addAll: self gtIncomingInheritances.
	all addAll: self gtIncomingTraitUsages.
	all addAll: self gtIncomingClassReferences.
	^ all select: [ :each | each fromPackage ~= self ]
]

{ #category : #'*GToolkit-DependencyAnalyzer' }
RPackage >> gtExtensionMethodReferences [
	"Return all classes referenced by extension methods from this package"

	^ (self methods collect: [:each | each methodReference ] thenSelect: [:each| each isValid and: [ each isExtension ] ])
		flatCollectAsSet: [ :m | 
			m method gtReferencedBehaviors collect: [ :each | 
				GtPharoClassReference new 
					referencingMethod: m; 
					referencedClass: each ]]
]

{ #category : #'*GToolkit-DependencyAnalyzer' }
RPackage >> gtIncomingClassExtensions [
	"Return a collection of methods that extend classes from this package"

	"Extensions to classes and traits"
	^ self definedClasses flatCollect: [ :each | each gtClassExtensions ]
]

{ #category : #'*GToolkit-DependencyAnalyzer' }
RPackage >> gtIncomingClassReferences [
	"Return all classes that reference classes in this package.
	This is opposite to #gtClassReferences"

	^ self definedClasses flatCollect: [ :eachBehavior | eachBehavior gtUsingMethods ]
]

{ #category : #'*GToolkit-DependencyAnalyzer' }
RPackage >> gtIncomingInheritances [
	"Find all classes that depend on classes in the package via inheritance"

	^ (self definedClasses 
		select: [ : each | each isClass ])
		flatCollect: [ :each | each gtDependentInheritances ]
]

{ #category : #'*GToolkit-DependencyAnalyzer' }
RPackage >> gtIncomingTraitUsages [
	^ (self definedClasses select: [ :eachBehavior | eachBehavior isTrait ]) flatCollect: [ :each | each gtTraitUsers ]
]

{ #category : #'*GToolkit-DependencyAnalyzer' }
RPackage >> gtInheritances [
	^ self definedClasses 
		select: [ : each | each isClass and: [ each superclass notNil ] ]
		thenCollect: [ :each | each gtInheritance ]
]

{ #category : #'*GToolkit-DependencyAnalyzer' }
RPackage >> gtMethodReferences [
	<return: #Collection of: #RGMethodDefinition>

	^ self methods collect: [:each | each methodReference ] thenSelect: [:each| each isValid and: [ each isLocalSelector ] ].
]

{ #category : #'*GToolkit-DependencyAnalyzer' }
RPackage >> gtPackageScope [
	^ self
]

{ #category : #'*GToolkit-DependencyAnalyzer' }
RPackage >> gtPackagesUsed [
	| result |
	result := Set new.
	result addAll: self gtPackagesUsedThroughClassExtensions.
	result addAll: self gtPackagesUsedThroughSubclassing.
	result addAll: self gtPackagesUsedThroughTraitUsages.
	result addAll: self gtPackagesUsedThroughClassReferences.
	^ result
	
]

{ #category : #'*GToolkit-DependencyAnalyzer' }
RPackage >> gtPackagesUsedThroughClassExtensions [
	^ self gtClassExtensions collectAsSet: [ :each | each toPackage ]
]

{ #category : #'*GToolkit-DependencyAnalyzer' }
RPackage >> gtPackagesUsedThroughClassReferences [
	^ (self gtClassReferences collectAsSet: [ :each | each toPackage ])
		remove: self ifAbsent: [];
		yourself
]

{ #category : #'*GToolkit-DependencyAnalyzer' }
RPackage >> gtPackagesUsedThroughSubclassing [
	^ (self gtInheritances collectAsSet: [ :each | each toPackage ]) 
		remove: self ifAbsent: []; 
		yourself
]

{ #category : #'*GToolkit-DependencyAnalyzer' }
RPackage >> gtPackagesUsedThroughTraitUsages [
	^ (self gtTraitUsages collectAsSet: [ :each | each toPackage ])
		remove: self ifAbsent: [];
		yourself
]

{ #category : #'*GToolkit-DependencyAnalyzer' }
RPackage >> gtTraitUsages [
	^ self definedClasses flatCollect: [ :each | each gtTraitUsages ]
]
