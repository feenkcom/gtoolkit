*GToolkit-Connector
beConnectedTo: anObject
	self userData
		at: #connectorConnections
		ifPresent: [ :aCollection | aCollection add: anObject ]
		ifAbsentPut: [ Set with: anObject ]