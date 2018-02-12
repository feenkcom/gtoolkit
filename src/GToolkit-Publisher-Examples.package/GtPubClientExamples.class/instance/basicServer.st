server - basic
basicServer
	<gtExample>
	<label: 'Basic server that does not know anything'>
	<after: #stopBasicServer>
	^ server ifNil: [ 
		server := (ZnServer startOn: 0)
			delegate: ZnDispatcherDelegate new;
			yourself ].