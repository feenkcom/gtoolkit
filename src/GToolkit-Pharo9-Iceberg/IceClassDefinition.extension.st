Extension { #name : #IceClassDefinition }

{ #category : #'*GToolkit-Pharo9-Iceberg' }
IceClassDefinition >> removeFromPatcher: aMCPatcher [

	"This code is taken from https://github.com/pharo-vcs/iceberg/pull/1572 to fix feenkcom/gtoolkit#2431"

	"If the meta side is removed, we should modify the class definition to not include the meta-parts such as class-instance-variables"

	self asMCDefinition ifNil: [ ^ self ].

	isMeta ifTrue: [ 
		^ aMCPatcher
			  modifyDefinition: self asMCDefinition
			  to: self asMCDefinitionWithoutMetaSide ].

	aMCPatcher removeDefinition: self asMCDefinition
]
