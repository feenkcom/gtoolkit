accessing
cache
	^ cache ifNil: [ cache := self defaultCache ]