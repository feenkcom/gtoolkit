Class {
	#name : #GtWorldTabToolbarButtonLook,
	#superclass : #BrStyleCommonLook,
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
		default: [ :aStyle |
			aStyle geometry: BlCircle new.
			aStyle layout: BlLinearLayout horizontal alignCenter.
			aStyle background: (Color transparent) ];
		hovered: [ :aStyle | aStyle background: (Color gray alpha: 0.2) ];
		pressed: [ :aStyle | aStyle background: (Color gray alpha: 0.4) ]
]
