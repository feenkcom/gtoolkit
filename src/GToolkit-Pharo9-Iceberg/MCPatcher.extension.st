Extension { #name : #MCPatcher }

{ #category : #'*GToolkit-Pharo9-Iceberg' }
MCPatcher >> modifyDefinition: baseDefinition to: targetDefinition [

	"this code is taken from: https://github.com/pharo-project/pharo/pull/10950 to fix gtoolkit/feenkcom#2431"

	"Only modify the definition if present"

	self definitions
		definitionLike: baseDefinition
		ifPresent: [ :found | 
			found = baseDefinition ifTrue: [ 
				self addDefinition: targetDefinition ] ]
		ifAbsent: [ "nothing" ]
]
