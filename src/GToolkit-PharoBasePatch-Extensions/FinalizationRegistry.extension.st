Extension { #name : #FinalizationRegistry }

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
FinalizationRegistry >> removeEphemeron: anEphemeron [
	<gtPharoPatch: #Pharo12>
	self protected: [
		anEphemeron link ifNotNil: [ :aLink | ephemeronList removeLink: aLink ].
		anEphemeron link: nil ]
]
