Class {
	#name : #GtHomeCollector,
	#superclass : #GtPhlowCollector,
	#category : #'GToolkit-World-Utilities'
}

{ #category : #actions }
GtHomeCollector >> collect [
	<return: #Array of: #GtPhlowView>
	<gtCollector>
	| stencils |
	stencils := self collectPragmas
		collect: [ :eachPragma | 
			"Add error handling"
			thisContext
				object: self object
				perform: eachPragma methodSelector
				withArguments: {}
				inClass: self object class ].
	self sortByPriority: stencils.
	^ stencils
]

{ #category : #initialization }
GtHomeCollector >> initializePragmaNames [
	pragmaNames := { self class defaultPragmaName }
]
