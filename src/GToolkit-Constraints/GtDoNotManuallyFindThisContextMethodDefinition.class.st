Class {
	#name : #GtDoNotManuallyFindThisContextMethodDefinition,
	#superclass : #GtPharoConstraint,
	#category : #'GToolkit-Constraints-GToolkit-Constraints'
}

{ #category : #accessing }
GtDoNotManuallyFindThisContextMethodDefinition >> description [
	^ 'In Pharo9 Context>>#method is deprecated as it can return CompiledBlock or CompiledMethod'
]

{ #category : #accessing }
GtDoNotManuallyFindThisContextMethodDefinition >> issues [
	^ #asRingDefinition senders select: [ :each |
		(RBParseTreeSearcher
			treeMatching: 'thisContext ``@messages'
			in: each ast)
				ifNil: [ false ]
				ifNotNil: [ :thisContextNode |
					(thisContextNode parents anySatisfy: [ :eachParent |
						eachParent isMessage and: [ eachParent selector = #asRingDefinition ] ])
							and: [ thisContextNode parents anySatisfy: [ :eachParent |
						eachParent isMessage and: [ eachParent selector = #method ] ] ] ] ]
]
