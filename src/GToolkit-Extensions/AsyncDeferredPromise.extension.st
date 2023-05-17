Extension { #name : #AsyncDeferredPromise }

{ #category : #'*GToolkit-Extensions' }
AsyncDeferredPromise >> gtChainedPromises [
	"Return a collection of promises that are next in the chain after this one"
	<return: #Collection of: #TAsyncPromise>

	^ mutex critical: [ chainedPromises copy ]
]

{ #category : #'*GToolkit-Extensions' }
AsyncDeferredPromise >> gtCompositionChildren [
	^ #( )
]

{ #category : #'*GToolkit-Extensions' }
AsyncDeferredPromise >> gtCompositionDescription [
	^ self printString
]

{ #category : #'*GToolkit-Extensions' }
AsyncDeferredPromise >> gtFullPromiseTreeFor: aView [
	<gtView>
	
	^ aView mondrian
		title: 'Full tree';
		priority: 3;
		painting: [ :aMondrian | self gtPaintFullTreeOn: aMondrian ]
]

{ #category : #'*GToolkit-Extensions' }
AsyncDeferredPromise >> gtPromiseTreeFor: aView [
	<gtView>
	
	^ aView mondrian
		title: 'Promise tree';
		priority: 2;
		painting: [ :aMondrian | self gtPaintTreeWith: aMondrian ]
]
