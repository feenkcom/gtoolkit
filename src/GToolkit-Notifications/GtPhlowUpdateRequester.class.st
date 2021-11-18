"
I handle asynchronous {{gtClass:BlElement}} update requests.
When {{gtMethod:GtPhlowUpdateRequester>>#requestUpdate|label=#selector}} is called, I {{gtMethod:GtPhlowUpdateRequester>>#postponeUpdate|label=schedule}} an update and execute an {{gtMethod:GtPhlowUpdateRequester>>#action|label=#selector}}, when the {{gtClass:BlElement}} is  {{gtMethod:BlElement>>#isAttachedToSceneGraph|label=attached to a scene graph}}.
# Public API
- {{gtMethod:GtPhlowUpdateRequester>>#element:|label=#selector}} a {{gtClass:BlElement}} on which updates are performed,
- {{gtMethod:GtPhlowUpdateRequester>>#action:|label=#selector}} a valuable which is evaluated when it is time to update the {{gtClass:BlElement}},
- {{gtMethod:GtPhlowUpdateRequester>>#element:selector:|label=#selector}} an utility method that combines the above two methods,
- {{gtMethod:GtPhlowUpdateRequester>>#requestUpdate|label=#selector}} schedules the {{gtClass:BlElement}} update.
# Example
### Requester Initialization
The following example indicates how I can be initialized, having a {{gtClass:BlElement}} with a given background: {{gtExample:GtPhlowUpdateRequesterExamples>>#requesterWithElementAndAction|codeExpanded=false|previewExpanded=true}}
## Requesting Update
The background is updated on the {{gtMethod:GtPhlowUpdateRequester>>#requestUpdate|label=request}} when the {{gtClass:BlElement}} is attached to a scene graph: {{gtExample:GtPhlowUpdateRequesterExamples>>#updateRequest_AfterElementAddedInSceneGraph|codeExpanded=false|previewExpanded=true}}  

"
Class {
	#name : #GtPhlowUpdateRequester,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'element',
		'mutex',
		'isUpdateRequested',
		'action',
		'postponedDuration'
	],
	#category : #'GToolkit-Notifications-Basic'
}

{ #category : #testing }
GtPhlowUpdateRequester class >> isDeprecated [

	"Use BrElementUpdater instead"

	^ true
]
