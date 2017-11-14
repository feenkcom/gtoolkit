children hooks
onRemovedFromSceneGraph
	super onRemovedFromSceneGraph.
	
	self fireEvent: GtConnectorButtonRemovedFromSceneGraph new.
	self dispatchEvent: (BlElementRemovedEvent target: self).