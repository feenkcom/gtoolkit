Extension { #name : #Class }

{ #category : #'*GToolkit-DependencyAnalyzer' }
Class >> gtClassExtensions [
	"Return all extension methods of this class"

	^ self extensionSelectors collect: [ :eachSelector | GtPharoClassExtension new extendingMethod: self >> eachSelector ]
]

{ #category : #'*GToolkit-DependencyAnalyzer' }
Class >> gtDependentInheritances [
	"Find all classes that depend on this class via inheritance"

	^ self subclasses collect: [ :eachSubclass | GtPharoInheritance new subclass: eachSubclass; superclass: self ]
]

{ #category : #'*GToolkit-DependencyAnalyzer' }
Class >> gtInheritance [
	^ GtPharoInheritance new subclass: self; superclass: self superclass
]

{ #category : #'*GToolkit-DependencyAnalyzer' }
Class >> gtTraitUsages [
	^ self traits collect: [ :each | GtPharoTraitUsage new baseBehavior: self; usedTrait: each ]
]
