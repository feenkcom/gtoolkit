private
doHandle
	"Handle (style) given script, represented by script parameters and tokens, in the target text"
	self styleParameters.
	epiceaLog := GtEpiceaLog fromFileReference: self fileReference.
	self styleExpandingCode