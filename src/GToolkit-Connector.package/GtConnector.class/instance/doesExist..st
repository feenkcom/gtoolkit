testing
doesExist: anElement
	^ (anElement hasParent: self) or: [ anElement isAttachedToSceneGraph ]