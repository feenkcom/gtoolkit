*GToolkit-Connector
beNotConnectedTo: anObject
	self userData
		at: #connectorConnections
		ifPresent: [ :aCollection | aCollection remove: anObject ]