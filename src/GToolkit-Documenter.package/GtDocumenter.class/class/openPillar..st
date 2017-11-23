opening
openPillar: aPillarFile
	| aSpace |

	aSpace := BlSpace new.
	aSpace title: aPillarFile asFileReference basename.
	aSpace root addChild: (self editorForPillar: aPillarFile).
	aSpace show