Class {
	#name : #GtWorldSpace,
	#superclass : #BlSpace,
	#category : #'GToolkit-World'
}

{ #category : #'instance creation' }
GtWorldSpace class >> open [
	<script: 'self open'>
	| aSpace |
	
	aSpace := GtWorldSpace new.
	aSpace title: 'World'.
	aSpace showSpace: (GtWorld create).
	aSpace show
]

{ #category : #initialization }
GtWorldSpace >> defaultRoot [
	| aTabGroup |
		
	aTabGroup := BrTabGroup new.
	aTabGroup background: Color white.
	aTabGroup look: BrGlamorousTabGroupLook new.

	^ super defaultRoot addChild: aTabGroup as: #tabs
]

{ #category : #'api - displaying' }
GtWorldSpace >> showSpace: aSpace [
	(self root childNamed: #tabs) addTab: (BrTab new
		select;
		look: BrGlamorousTabLook new;
		label: aSpace title;
		stencil: [
			aSpace root dispatchRemovedFromSceneGraph.
			aSpace root
				constraintsDo: [ :c |
					c horizontal matchParent.
					c vertical matchParent ] ])
]
