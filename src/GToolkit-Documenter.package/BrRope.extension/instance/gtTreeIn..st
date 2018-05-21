*GToolkit-Documenter
gtTreeIn: anElement
	| view |
	view := GtMondrian new.
	self viewBlocTreeOn: view.
	view gtLiveIn: anElement