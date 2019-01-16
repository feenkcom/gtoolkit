"load latest version"
EpMonitor current disable.
Metacello new
  baseline: 'GToolkit';
  repository: ('github://feenkcom/gtoolkit', (OSEnvironment current at: 'TAG_NAME' ifPresent: [ :value | '' join: {':'. value}] ifAbsent:['']) ,'/src' );
  load.
EpMonitor current enable.
Smalltalk snapshot: true andQuit: false.
