Extension { #name : #ZnDispatcherDelegate }

{ #category : #'*GToolkit-Extensions' }
ZnDispatcherDelegate >> gtDelegateFor: aView [ 
	^ self gtMapFor: aView
]

{ #category : #'*GToolkit-Extensions' }
ZnDispatcherDelegate >> gtMapFor: aView [
	<gtView>
	^ (self dispatcherDictionary gtItemsFor: aView)
		title: 'Access point handlers'
]
