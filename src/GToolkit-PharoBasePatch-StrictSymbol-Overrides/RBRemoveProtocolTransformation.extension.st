Extension { #name : #RBRemoveProtocolTransformation }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
RBRemoveProtocolTransformation >> applicabilityPreconditions [
	"Protocol names are Symbols; the transformation gets a String"
	<gtPharoPatch: #StrictComparison>

	^ {
		  self classExist.
		  (RBCondition
			   withBlock: [
				   (model environment protocolsFor: self definingClass realClass)
					   anySatisfy: [ :prot | prot name = protocol asSymbol ] ]
			   errorString: 'Protocol named ' , protocol , ' does not exist').
		  (RBCondition
			   withBlock: [
			   (self definingClass realClass protocolNamed: protocol) isEmpty ]
			   errorString: 'Protocol named ' , protocol
				   , ' is not empty and it cannot be removed') }
]
