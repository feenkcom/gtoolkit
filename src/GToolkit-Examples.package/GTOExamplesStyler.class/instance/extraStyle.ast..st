private
extraStyle: aText ast: ast
	super style: aText ast: ast.
	(ast pragmas anySatisfy: [ :each | each selector = #gtExample ]) ifTrue: [ 
		ast pragmas do: [ :each |
			each selector = #dependsOn: ifTrue: [ 
				aText 
					attributes: { BrTextExpandButtonAttribute new attributesCreatingBlock: [" BrTextAdornmentDynamicAttribute new adornmentBlock: [ BlElement new size: 70 @ 50; background: Color red; yourself ]"] } 
					from: each left
					to: each right.
				Transcript 
					show: (each left -> each right) asString;
					cr;
					show: (aText asString copyFrom: each left to: each right) ] ] 
	]