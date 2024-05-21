Extension { #name : #BlockClosure }

{ #category : #'*GToolkit-PharoBasePatch-Deprecations' }
BlockClosure >> ifError: errorHandlerBlock [		
	<gtPharoPatch: #Pharo>
	
	^ self on: Error do: [:ex |
		errorHandlerBlock cull: ex description cull: ex receiver ]
]

{ #category : #'*GToolkit-PharoBasePatch-Deprecations' }
BlockClosure >> ifErrorDo: errorHandlerBlock [
	<gtPharoPatch: #Pharo>
	
	^ self on: Error do: [:ex |
		errorHandlerBlock cull: ex description cull: ex receiver ]
]
