EpMonitor disableDuring:
[ 
Metacello new
	baseline: 'GtThreadedFFIDev';
	repository: 'github://feenkcom/tffi-dev/src';
	load.
].

"Alien callbacks and Threaded FFI callbacks may not be used in the same session.
The following message send must be the last thing executed before saving the image and quitting."
ThreadedFFIMigration enableThreadedFFI.
