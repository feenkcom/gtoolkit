Extension { #name : #BlockClosure }

{ #category : #'*GToolkit-Pharo9-Deprecations' }
BlockClosure >> ifError: errorHandlerBlock [		
	<gtPharoPatch: #Pharo>
	
	^ self on: Error do: [:ex |
		errorHandlerBlock cull: ex description cull: ex receiver ]
]

{ #category : #'*GToolkit-Pharo9-Deprecations' }
BlockClosure >> ifErrorDo: errorHandlerBlock [
	<gtPharoPatch: #Pharo>
	
	^ self on: Error do: [:ex |
		errorHandlerBlock cull: ex description cull: ex receiver ]
]
