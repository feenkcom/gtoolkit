actions
cleanWorkspace
	"GtDocument may keep unused code snippet results in out.
	Extra results are removed."
	self workspace outs size = scriptIndex ifTrue: [ ^ self ].
	self workspace outs removeAllAfterIndex: scriptIndex.