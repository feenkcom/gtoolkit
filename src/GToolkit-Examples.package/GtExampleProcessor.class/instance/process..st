private
process: anExample
	^ self basicProcess: anExample
	"^ self process: anExample withoutLoopsDo: [ 
		self onProcess value: self value: anExample ]"