private
doHandle
	"Handle (style) given script, represented by script parameters and tokens, in the target text"

	self styleParameters.
	self scriptBodyString ifEmpty: [ ^ self ].
	self styleScriptBody.
	self hasShowParameter ifFalse: [ ^ self ].
	self styleExpandingCode