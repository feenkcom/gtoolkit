Class {
	#name : #GtWorld,
	#superclass : #BlSpace,
	#category : #'GToolkit-World-UI'
}

{ #category : #'instance creation' }
GtWorld class >> open [
	<script: 'self open'>
	| aSpace |
	
	aSpace := GtWorld new.
	aSpace title: 'Glamorous Toolkit'.
	aSpace show
]

{ #category : #'instance creation' }
GtWorld class >> openWithShutdownListener [
	<script: 'self openWithShutdownListener'>
	| aSpace |
	
	aSpace := GtWorld new.
	aSpace title: 'Glamorous Toolkit'.
	aSpace addEventHandler: BlSpaceShutdownOnCloseListener new.
	aSpace show.
]

{ #category : #'instance creation' }
GtWorld class >> openWithSpaces: aCollectionOfSpaces [
	| aSpace |

	aSpace := GtWorld new.
	aSpace title: 'Glamorous Toolkit'.

	aCollectionOfSpaces do: [ :eachSpace |
		aSpace root showSpace: eachSpace ].

	aSpace show
]

{ #category : #initialization }
GtWorld >> defaultRoot [
	^ GtWorldElement new
]
