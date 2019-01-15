"load latest version"
EpMonitor current disable.
tag := OSEnvironment current at: 'TAG_NAME' ifPresent: [ :value | '' join: {':'. value}] ifAbsent:[''].
Metacello new
  baseline: 'GToolkit';
  repository: ('github://feenkcom/gtoolkit/src', tag);
  load.
EpMonitor current enable.
Smalltalk snapshot: true andQuit: false.
