opening
editorForPillar: aPillarFile
	| text styler editor editorElement fileReference scalable zoomLevel |

	zoomLevel := 1.0.

	fileReference := aPillarFile asFileReference.
	
	text := BrRopedText string: fileReference contents.
	styler := GtPillarStyler new fileReference: fileReference.
	editor := BrTextEditor new.
	editor styler: styler.
	editor text: text.
	editorElement := BrEditorElement new.
	editorElement constraintsDo: [ :c |
	    c horizontal matchParent.
	    c vertical matchParent ].
	editorElement editor: editor.
	
	scalable := BlScalableElement new.
	scalable contentElement: editorElement.
	scalable constraintsDo: [ :c |
	    c horizontal matchParent.
	    c vertical matchParent ].
	scalable fixed: zoomLevel.
	scalable addShortcut: (BlShortcut new
		combination: (BlKeyCombination builder meta; key: Key equal; build);
		action: [
			zoomLevel := zoomLevel + 0.1.
			scalable fixed: zoomLevel ]).
	scalable addShortcut: (BlShortcut new
		combination: (BlKeyCombination builder meta; key: Key minus; build);
		action: [
			zoomLevel := zoomLevel - 0.1.
			scalable fixed: zoomLevel ]).
	^ scalable