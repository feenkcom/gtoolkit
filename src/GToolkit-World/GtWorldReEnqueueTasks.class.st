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
	^ actualSpace
]

{ #category : #hooks }
GtWorldReEnqueueTasks >> onEnqueued: aSpace [
	actualSpace := aSpace
]

{ #category : #'private - accessing' }
GtWorldReEnqueueTasks >> previousSpace [
	^ previousSpace
]

{ #category : #'api - accessing' }
GtWorldReEnqueueTasks >> previousSpace: aSpace [
	previousSpace := aSpace
]

{ #category : #'api - running' }
GtWorldReEnqueueTasks >> run [
	self actualSpace ifNil: [ ^ self ].
	self previousSpace ifNil: [ ^ self ].
	self actualSpace enqueueTasksFrom: self previousSpace taskQueue.
]
