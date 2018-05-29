api - instantiation
create
	| view |
	view := GtPhlowExplicitView new.
	
	self inspectedObject gtViewsFor: view.
	
	^ view asElementDo: [ :element |
		element constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ] ]