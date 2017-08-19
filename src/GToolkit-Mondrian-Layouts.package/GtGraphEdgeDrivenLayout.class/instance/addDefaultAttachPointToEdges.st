default attach points
addDefaultAttachPointToEdges
	self flag: 'Model attach points'.
	
	"edges do: [ :e | e shape attachPoint: self defaultAttachPoint ]"