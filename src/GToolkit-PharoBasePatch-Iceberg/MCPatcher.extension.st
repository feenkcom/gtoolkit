Extension { #name : #MCPatcher }

{ #category : #'*GToolkit-PharoBasePatch-Iceberg' }
MCPatcher >> modifyDefinition: baseDefinition to: targetDefinition [
	<gtPharoPatch: #Pharo>
	
	"This check is for https://github.com/feenkcom/gtoolkit/issues/2457"
	baseDefinition ifNil: [
		^ self addDefinition: targetDefinition ].
	
	"This code is taken from: https://github.com/pharo-project/pharo/pull/10950 to fix gtoolkit/feenkcom#2431"
	
	"Only modify the definition if present"
 
	self definitions
		definitionLike: baseDefinition
		ifPresent: [ :found | 
			found = baseDefinition ifTrue: [ 
				self addDefinition: targetDefinition ] ]
		ifAbsent: [ "nothing" ]
]
