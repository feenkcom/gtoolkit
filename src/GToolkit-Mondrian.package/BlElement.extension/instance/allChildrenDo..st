*GToolkit-Mondrian
allChildrenDo: aBlock 
	self childrenDo: aBlock.
	self childrenDo: [ :each | each allChildrenDo: aBlock ]