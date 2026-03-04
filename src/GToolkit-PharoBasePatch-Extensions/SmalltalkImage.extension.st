Extension { #name : #SmalltalkImage }

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
SmalltalkImage >> createRbNamespace [
	^ self 
		forPharo12AndNewer: [ GtRBNamespace ] 
		forPharo11: [ RBClassModelFactory rbNamespace ]
]

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
SmalltalkImage >> metacelloPlatformAttributes [
	<gtPharoPatch: #Pharo>
	"Returns the tags for the conditional platform loading in Metacello. Pay attention the order is important: from most  to least general."

	^ {
		  #squeakCommon.
		  #pharo.
		  ('pharo' , SystemVersion current major asString , '.x') asSymbol.
		  ('pharo' , SystemVersion current major asString , '.0.x') asSymbol.
		  #gtoolkit.
		  ('gtoolkit-pharo' , SystemVersion current major asString , '.x') asSymbol.
		  ('gtoolkit-pharo' , SystemVersion current major asString , '.0.x') asSymbol. }
]
