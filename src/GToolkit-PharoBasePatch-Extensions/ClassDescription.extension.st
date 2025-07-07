Extension { #name : #ClassDescription }

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
ClassDescription >> organization [
	"Answer the instance of ClassOrganizer that represents the organization
	of the messages of the receiver."

	self
		forPharo12: [ ^ self ]
		forPharo11AndPharo10: [ 
			self basicOrganization
				ifNil: [ 
					self
						basicOrganization: (self isTrait
								ifTrue: [ ClassOrganization new ]
								ifFalse: [ ClassOrganization forClass: self ]) ].
			^ self basicOrganization setSubject: self	"Making sure that subject is set correctly. It should not be necessary." ]
]

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
ClassDescription >> protocolNames [
	<gtPharoPatch: #Pharo12>
	"Return the list of all the protocol names included in this class."

	^ self 
		forPharo12: [
			self protocols collect: [ :protocol | protocol name ] ]
		forPharo11AndPharo10: [
			self organization categories ] 
]
