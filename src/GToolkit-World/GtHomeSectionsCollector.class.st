Class {
	#name : #GtHomeSectionsCollector,
	#superclass : #GtPhlowCollector,
	#category : #'GToolkit-World'
}

{ #category : #accessing }
GtHomeSectionsCollector class >> defaultHomeSectionPragmaName [
	^ #gtHomeSection
]

{ #category : #actions }
GtHomeSectionsCollector >> collect [
	<return: #Array of: #GtPhlowView>
	<gtCollector>
	| sectionStencils |
	sectionStencils := self collectPragmas
		collect: [ :eachPragma | 
			"Add error handling"
			thisContext
				object: self object
				perform: eachPragma methodSelector
				withArguments: {}
				inClass: self object class ].
	sectionStencils sort: [ :a :b | 
		[a priority < b priority]
			on: Error
			do: [ :error | 
				"Log error"
				true ] ].
	^ sectionStencils
]

{ #category : #initialization }
GtHomeSectionsCollector >> initializePragmaNames [
	pragmaNames := { self class defaultHomeSectionPragmaName }
]
