Class {
	#name : #GtBlogPostList,
	#superclass : #Object,
	#instVars : [
		'posts'
	],
	#category : #'GToolkit-World-Utilities'
}

{ #category : #'gt-extension' }
GtBlogPostList >> gtPostsFor: aView [
	<gtView>
	self posts ifNil: [ ^ aView empty ].
	^ aView forward 
		title: 'Posts';
		object: [ self posts ];
		view: #gtItemsFor:
]

{ #category : #accessing }
GtBlogPostList >> posts [
	^ posts
]

{ #category : #accessing }
GtBlogPostList >> posts: anObject [
	posts := anObject
]
