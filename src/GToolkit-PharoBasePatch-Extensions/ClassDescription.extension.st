Extension { #name : #ClassDescription }

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
ClassDescription >> organization [
	"Answer the instance of ClassOrganizer that represents the organization
	of the messages of the receiver."

	 ^ self 
]

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
ClassDescription >> protocolNameOfSelector: aSelector [
	"Return the protocol name including the method of the same name as the selector.
	If the class does not includes a method of this name, returns nil. Maybe this should be changed for an error in the future."

	
	^ self 
		forPharo12AndNewer: [
			(self protocolOfSelector: aSelector) ifNotNil: [ :protocol | 
				protocol name ] ] 
		forPharo11: [
			self organization categoryOfElement: aSelector]
	
]

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
ClassDescription >> protocolNamed: aString ifAbsent: aBlock [

	^ self 
		forPharo12AndNewer: [
			self protocols
		 		 detect: [ :e | e name = aString ]
		  		ifNone: aBlock] 
		forPharo11: [
			self organization protocolOrganizer
				protocolNamed: aString
				ifAbsent: aBlock ] 
]

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
ClassDescription >> protocolNames [
	<gtPharoPatch: #Pharo12>
	"Return the list of all the protocol names included in this class."

	^ self 
		forPharo12AndNewer: [
			self protocols collect: [ :protocol | protocol name ] ]
		forPharo11: [
			self organization categories ] 
]
