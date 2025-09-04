Extension { #name : #IceSystemEventListener }

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
IceSystemEventListener class >> handleMethodChange: aMethodChange [
	<gtPharoPatch: #Pharo12>
	aMethodChange class name = #GtMethodRecompiled ifTrue: [ 
		"Ignore method recompilations that happen as a result of resolving
		references to undeclared classes. They do not change the source code.
		https://github.com/feenkcom/gtoolkit/issues/4650"
		^ self ].
		
	self handlePackagesChange: aMethodChange packagesAffected
]
