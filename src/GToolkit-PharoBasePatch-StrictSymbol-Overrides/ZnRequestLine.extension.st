Extension { #name : #ZnRequestLine }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
ZnRequestLine >> method: string [
	"ZnConstants knownHTTPMethods are Symbols; ZnRequestLine>>#readFrom: passes the method of the request line as a String.
	Compare by content: the request adds no Symbol to the image and reads no Symbol table. The method is the known Symbol."
	<gtPharoPatch: #StrictComparison>
	method := ZnConstants knownHTTPMethods
		detect: [ :each | each sameContentAs: string ]
		ifNone: [ (ZnUnknownHttpMethod method: string) signal ]
]
