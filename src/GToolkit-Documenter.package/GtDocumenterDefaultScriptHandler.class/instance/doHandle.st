private
doHandle
	"Handle (style) given script, represented by script parameters and tokens, in the target text"

	| expandingAttribute |
	self scriptBodyString ifEmpty: [ ^ self ].
	self styleScriptBody.
	self hasShowParameter ifFalse: [ ^ self ].
	expandingAttribute := BrTextExpandButtonAttribute new
		attributesCreatingBlock: [ self newPreviewAttribute ].
	self targetText
		attributes: {expandingAttribute}
		from: self closingBracketsStartingPosition
		to: self closingBracketsEndPosition