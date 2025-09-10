Extension { #name : #RGElementDefinition }

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
RGElementDefinition >> realParent [
	"Retrieves the Class/Trait/.. object in the System corresponding to the class of the this element."
	<gtPharoPatch: #Pharo12>
	| realParent |

	realParent := parent
		          ifNotNil: [ parent realClass ]
		          ifNil: [ self rootEnvironment classNamed: self parentName ].
	realParent ifNil: [ ^ nil ].

	self 
		forPharo12AndNewer: [
			self isMeta ifTrue: [ realParent := realParent classSide ]]
		forPharo11: [
			self isMetaSide ifTrue: [ realParent := realParent classSide ] ].
	
	^ realParent
]
