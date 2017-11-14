*GToolkit-Connector
isConnectorSource
	^ self userData
		at: #isConnectorSource
		ifAbsent: [ false ]