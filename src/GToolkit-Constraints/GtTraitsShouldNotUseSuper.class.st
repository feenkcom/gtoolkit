Class {
	#name : 'GtTraitsShouldNotUseSuper',
	#superclass : 'GtPharoConstraint',
	#category : 'GToolkit-Constraints-GToolkit-Constraints'
}

{ #category : 'accessing' }
GtTraitsShouldNotUseSuper >> description [
	^ 'Pharo 9 forbids `super` in traits.'
]

{ #category : 'accessing' }
GtTraitsShouldNotUseSuper >> issues [
	^ (Smalltalk image allTraits select: [ :eachTrait |
		#('Bloc' . 'Brick' . 'GToolkit' ) anySatisfy: [ :prefix |
			eachTrait package name beginsWith: prefix ] ])
		flatCollect: [ :eachTrait |
			eachTrait methods select: [ :eachMethod | 
				eachMethod ast allChildren anySatisfy: [ :each | each isSuper ] ] ]
]
