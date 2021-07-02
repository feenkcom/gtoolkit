EpMonitor disableDuring:
[
Iceberg enableMetacelloIntegration: false.
Metacello new
	baseline: 'GtThreadedFFIDev';
	repository: 'github://feenkcom/tffi-dev:ffi-backport/src';
	load.

Metacello new
	baseline: 'ThreadedFFIMigration';
	repository: 'github://feenkcom/threadedFFI-Plugin/src';
	load.
Iceberg enableMetacelloIntegration: true.
].
"Alien callbacks and Threaded FFI callbacks may not be used in the same session.
The following message send must be the last thing executed before saving the image and quitting."
ThreadedFFIMigration enableThreadedFFI.

Smalltalk snapshot: true andQuit: false.