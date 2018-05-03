private
doHandle
	"Handle (style) given script, represented by script parameters and tokens, in the target text"

	self styleParameters.
	tokens scriptBodyString ifEmpty: [ ^ self ].
	self styleScriptBody.
	tokens hasShowParameter ifFalse: [ ^ self ].
	self styleExpandingCode