Class {
	#name : #GtWorldTabToolbarButtonLook,
	#superclass : #BrInteractiveCommonLook,
	#category : #'GToolkit-World-UI'
}

{ #category : #initialization }
GtWorldTabToolbarButtonLook >> initialize [
	super initialize.
	
	self addAll: { 
		BrGlamorousButtonIconLook new.
		BrGlamorousButtonWithLabelTooltipLook new.
		BrLayoutResizerLook inherit.
		BrLayoutAlignmentLook forHorizontalLinearLayout }.

	self
		default: [ :aWidget |
			aWidget geometry: BlCircle new.
			aWidget layout: BlLinearLayout horizontal alignCenter.
			aWidget background: (Color transparent) ];
		hovered: [ :aWidget | aWidget background: (Color gray alpha: 0.2) ];
		pressed: [ :aWidget | aWidget background: (Color gray alpha: 0.4) ]
]
