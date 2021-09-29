Class {
	#name : 'GtDoNotManuallyFindThisContextMethodDefinition',
	#superclass : 'GtPharoConstraint',
	#category : 'GToolkit-Constraints-GToolkit-Constraints'
}

{ #category : 'accessing' }
GtDoNotManuallyFindThisContextMethodDefinition >> description [
	^ 'In Pharo9 Context>>#method is deprecated as it can return CompiledBlock or CompiledMethod'
]

{ #category : 'accessing' }
GtDoNotManuallyFindThisContextMethodDefinition >> issues [
	^ ('`{:node | | found | found := false. node nodesDo: [:each | found := found or: [each isKindOf: RBThisContextNode]]. found} asRingDefinition' gtASTMatches result collect: #yourself)
		select: [ :eachMethod |
			#('Bloc' . 'Brick' . 'GToolkit' ) anySatisfy: [ :prefix | 
				eachMethod package name beginsWith: prefix ] ]
]
