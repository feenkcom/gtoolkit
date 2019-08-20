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
	aTabGroup look: BrGlamorousSpaceTabGroupLook new.

	^ super defaultRoot addChild: aTabGroup as: #tabs
]

{ #category : #'api - displaying' }
GtWorldSpace >> showSpace: aSpace [
	| aTab |
	
	aTab := nil.
	aTab := (BrTab new
		look: BrGlamorousSpaceTabLook new;
		select;
		label: aSpace title;
		stencil: [
			aSpace root dispatchRemovedFromSceneGraph.
			aSpace root
				constraintsDo: [ :c |
					c horizontal matchParent.
					c vertical matchParent ] ];
		actionbarStencil: [
			BrButton new
				exact: 20@12;
				opacity: 0.5;
				margin: (BlInsets top: 2 left: 4 bottom: 0 right: 0);
				look: BrGlamorousButtonRectangularLook + BrGlamorousButtonIconLook + BrGlamorousButtonWithLabelTooltipLook;
				icon: BrGlamorousIcons close;
				label: 'Close';
				action: [ (self root childNamed: #tabs) removeTab: aTab ] ]).

	(self root childNamed: #tabs) addTab: aTab
]
