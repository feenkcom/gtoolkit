Extension { #name : #ClassDescription }

{ #category : #'*GToolkit-PharoBasePatch-ForPharo12' }
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
