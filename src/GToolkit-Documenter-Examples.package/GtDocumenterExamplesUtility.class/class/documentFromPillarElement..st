utility
documentFromPillarElement: aGtPillarEditorElement 
	<return: #GtDocument>
	| aDocument |
	aDocument := aGtPillarEditorElement document.
	self assert: aDocument notNil.
	self assert: aDocument outs notNil.
	^ aDocument