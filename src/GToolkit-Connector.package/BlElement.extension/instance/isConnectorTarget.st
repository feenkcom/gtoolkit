*GToolkit-Connector
isConnectorTarget
	^ self userData
		at: #isConnectorTarget
		ifAbsent: [ false ]