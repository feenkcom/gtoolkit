private
doHandle
	"Handle (style) given script, represented by script parameters and tokens, in the target text"
	| styler |
	self tokens third parsedValue notEmpty ifFalse: [ ^ self ].
	styler := BrRBTextStyler new.
	styler
		style: (self targetText from: self tokens third start to: self tokens third stop).
	self targetText
		attributes:
			{BrFontGenericFamilyAttribute monospace.
			(BrFontSizeAttribute size: 14)}
		from: self tokens third start
		to: self tokens third stop.
	self scriptParameters
		at: 'show'
		ifPresent: [ :selector | 
			| expandingAttribute |
			expandingAttribute := BrTextExpandButtonAttribute new
				attributesCreatingBlock: [ BrTextAdornmentDynamicAttribute new
						beAppend;
						elementBlockWithErrorCatching: [ | composite |
							composite := BlElement new
								layout: BlLinearLayout new;
								padding: (BlInsets all: 5);
								border: (BlBorder paint: Color veryLightGray width: 1);
								constraintsDo: [ :c | 
									c textFlow pushLine.
									c vertical exact: 100.
									c horizontal matchParent ].
							(Compiler evaluate: self tokens third parsedValue)
								perform: selector asSymbol
								withArguments: {composite}.
							composite ] ].
			self targetText
				attributes: {expandingAttribute}
				from: self tokens fourth start
				to: self tokens fourth stop ]