"
${class:BlSpace}$ moves ${class:BlTask}$ instances from ${class:BlElement}$ instances when they are attached to a ${class:BlSpace}$. 
Those spaces might not be displayed if ${method:GtWorldTabElement>>#showSpace:}$ is called.  For that reason we need to move such enqueued tasks from a not shown space to a new space in which elements are actually displayed. This is my job.
I am used by ${class:GtWorldElement}$.


"
Class {
	#name : #GtWorldReEnqueueTasks,
	#superclass : #BlTask,
	#instVars : [
		'previousSpace',
		'actualSpace'
	],
	#category : #'GToolkit-World-UI'
}

{ #category : #'private - accessing' }
GtWorldReEnqueueTasks >> actualSpace [
	"Return a space to which the actual element is attached to."
	<return: #BlSpace>
	^ actualSpace
]

{ #category : #'private - accessing' }
GtWorldReEnqueueTasks >> actualSpaceDo: aBlock [
	self actualSpace ifNotNil: aBlock
]

{ #category : #hooks }
GtWorldReEnqueueTasks >> onEnqueued: aSpace [
	actualSpace := aSpace
]

{ #category : #'private - accessing' }
GtWorldReEnqueueTasks >> previousAndActualSpaceDo: aBlock [
	self previousSpaceDo: [ :aPreviousSpace |
		self actualSpaceDo: [ :anActualSpace | 
			aBlock cull: aPreviousSpace cull: anActualSpace ] ]
]

{ #category : #'private - accessing' }
GtWorldReEnqueueTasks >> previousSpace [
	"Return a space to which the actual element was attached to."
	<return: #BlSpace>
	^ previousSpace at: 1
]

{ #category : #'api - accessing' }
GtWorldReEnqueueTasks >> previousSpace: aSpace [
	previousSpace := aSpace asWeakReference.
]

{ #category : #'private - accessing' }
GtWorldReEnqueueTasks >> previousSpaceDo: aBlock [
	self previousSpace ifNotNil: aBlock
]

{ #category : #'api - running' }
GtWorldReEnqueueTasks >> run [
	self previousAndActualSpaceDo: [ :aPreviousSpace :anActualSpace |
		anActualSpace enqueueTasksFrom: aPreviousSpace taskQueue ].
]
