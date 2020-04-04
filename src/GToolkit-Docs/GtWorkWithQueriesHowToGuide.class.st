"
!How to work with queries

One of the design principles behind Glamorous Toolkit is that search must be universal. This is achieved using queries.

!!What are queries?

They are small pieces of code, written in plain Pharo, that we can use to get information about a package, a class, a method or an object that satisfies one or more conditions.

Let's see an example: a search for all the methods annotated with the #gtView pragma.

${example:GtWorkWithQueriesHowToGuide>>#searchForGtViewPragmaMethods}$

Executing the query, opens up an inspector on the result which, in this case, is an instance of GtSearchPragmasFilter. The filter instance knows how to present itself through a view that shows method widgets. The method widgets know how to match the input query to the abstract syntax tree nodes to produce the orange highlighting.

But what if we want to search for multiple conditions at the same time? Well, queries can be composed using & and | messages, making this easily extensible.

Let's see an example: a search for all the methods that are annotated with the #gtView pragma and implement a tree view.

${example:GtWorkWithQueriesHowToGuide>>#searchForGtViewTreeMethods}$

Now let's search for those methods above, plus the ones that implement a columnedTree view.

${example:GtWorkWithQueriesHowToGuide>>#searchForGtViewTreeAndColumnedTreeMethods}$

Since queries are just plain Pharo code, we can combine them with Pharo methods like select: , collect: and others.

For example, this code snippet returns all example methods from packages starting with 'GToolkit'.

${example:GtWorkWithQueriesHowToGuide>>#exampleMethodsFromGToolkitPackages}$

Earlier we mentioned filters helping us to work with queries.

!!What are filters? 

They are predicates that work as conditions in the query.

For example, let's search certain methods in a certain package. The result will be an instance of GtSearchIntersectionFilter, being the intersetion of two filters: GtSearchReferencesFilter and GtSearchMethodsWithPackagePatternFilter.

${example:GtWorkWithQueriesHowToGuide>>#searchInCertainPackage}$

There already exists a number of such predicates readily available. You can see them by using a query.

${example:GtWorkWithQueriesHowToGuide>>#searchAllFilters}$

"
Class {
	#name : #GtWorkWithQueriesHowToGuide,
	#superclass : #Object,
	#category : #'GToolkit-Docs'
}

{ #category : #'as yet unclassified' }
GtWorkWithQueriesHowToGuide >> exampleMethodsFromGToolkitPackages [
	<gtExample>
	
	^ #gtExample gtPragmas select: [ :method | 
		method package name beginsWith: 'GToolkit'].
]

{ #category : #accessing }
GtWorkWithQueriesHowToGuide >> searchAllFilters [
	<gtExample>
	^ GtSearchFilter allSubclasses
		reject: [ :each | each gtReferences size = 0 ].
]

{ #category : #'as yet unclassified' }
GtWorkWithQueriesHowToGuide >> searchForGtExampleReferences [
	<gtExample>
	
	^ #gtExample gtReferences.
]

{ #category : #'as yet unclassified' }
GtWorkWithQueriesHowToGuide >> searchForGtViewPragmaMethods [
	<gtExample>
	
	^ #gtView gtPragmas.
]

{ #category : #'as yet unclassified' }
GtWorkWithQueriesHowToGuide >> searchForGtViewTreeAndColumnedTreeMethods [
	<gtExample>
	
	^ #gtView gtPragmas & (#tree gtReferences | #columnedTree gtReferences).
]

{ #category : #'as yet unclassified' }
GtWorkWithQueriesHowToGuide >> searchForGtViewTreeMethods [
	<gtExample>
	
	^ #gtView gtPragmas & #tree gtReferences.
]

{ #category : #'as yet unclassified' }
GtWorkWithQueriesHowToGuide >> searchInCertainPackage [
	<gtExample>
	
	^ #todo gtReferences & 'Bloc' gtPackageMatches.
]
