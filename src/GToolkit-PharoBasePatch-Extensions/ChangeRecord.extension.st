Extension { #name : #ChangeRecord }

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
ChangeRecord >> asMCMethodDefinition [
	"Creates a MCMethodDefinition from the receiver when this was created for a method (type=#method)"
	
	self type == #method ifFalse: [ ^nil ]. "This case shouldn't happen"
	
	^ MCMethodDefinition 
		className: class
		classIsMeta: meta
		selector: self methodSelector
		category: (self 
			forPharo12AndNewer: [self protocol] 
			forPharo11: [self category])
		timeStamp: stamp
		source: self string
]
