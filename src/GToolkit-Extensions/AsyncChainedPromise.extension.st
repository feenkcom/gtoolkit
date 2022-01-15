Extension { #name : #AsyncChainedPromise }

{ #category : #'*GToolkit-Extensions' }
AsyncChainedPromise >> gtHandlesErrors [
	"Return true if the promise is able to handle errors"

	^ rejectedComputation notNil
]

{ #category : #'*GToolkit-Extensions' }
AsyncChainedPromise >> gtPrecedingPromises [
	"Return a collection promises on which this promise depends"
	<return: #Collection of: #TAsyncPromise>

	^ { previousPromise }
]
