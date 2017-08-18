ui
open
	| space |
	space := BlSpace new.
	space extent: 600@400.
	space root addChild: self newEditorElement.
	space show