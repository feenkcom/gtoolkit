*GToolkit-Connector
isConnectedTo: anObject
	^ self userData
		at: #connectorConnections
		ifPresent: [ :aCollection | aCollection includes: anObject ]
		ifAbsent: [ false ]