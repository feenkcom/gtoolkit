scripting
connect: aCollection from: aFromBlock to: aToBlock
	| elements |
	elements := OrderedCollection new.
	aCollection do: [ :each |
		| fromObject toObject fromElement toElement line |
		fromObject := aFromBlock value: each.
		toObject := aToBlock value: each.
		self topStep root allChildrenBreadthFirstDo: [ :child |
			child isMondrianNode ifTrue: [ 
				| aMondrianModel |
				aMondrianModel := child mondrianModel.
				aMondrianModel = fromObject ifTrue: [ fromElement := child ].
				aMondrianModel = toObject ifTrue: [ toElement := child ] ] ].
		(toElement notNil and: [ fromElement notNil ])
			ifTrue: [ 
				line := self edgeElementFor: each from: fromElement to: toElement.
				self areEdgesPassive ifFalse: [ 
					self edgeConstraintsFrom: fromElement to: toElement ].
				elements add: line ] ].
	self topStep root addChildren: elements.
	^ elements