I allow users to edit GT-Examples and support a preview of the result.

!! Example:

[[[
	| example exampleElement |
	"Acquire an instance of GT-Example we are interested in"
	example := (BrTextEditorExamples >> #newElement) gtExample.
	"create example element"
	exampleElement := GTOPillarExampleElement new.
	exampleElement size: 300@100.
	"attach GT-Example"
	exampleElement example: example.
	"specify how example's return value should be transformed into an element"
	exampleElement previewShowBlock: #gtoLive
]]]