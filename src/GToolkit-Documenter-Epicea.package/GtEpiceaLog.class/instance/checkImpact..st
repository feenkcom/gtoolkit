testing
checkImpact: entries
	^ entries anySatisfy: [ :eachEntry | 
		eachEntry content accept: (EpHasImpactVisitor inEnvironment: self theEnvironment) ]