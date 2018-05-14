private
doHandle
	"Handle (style) given script, represented by script parameters and tokens, in the target text"
	self styleParameters.
	self styleScriptBody.
	self styleExecutableCode.
	self codeSnippet hasResult ifTrue: [ self styleExpandingCode ].