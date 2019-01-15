"load latest version"
EpMonitor current disable.
Metacello new
  baseline: 'GToolkit';
  repository: ('github://feenkcom/gtoolkit/src', (OSEnvironment current at: 'TAG_NAME' ifPresent: [ :value | '' join: {':'. value}] ifAbsent:['']) );
  load.
EpMonitor current enable.
Smalltalk snapshot: true andQuit: false.
