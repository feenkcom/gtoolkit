timeToRun := [EpMonitor current disable.
Metacello new
  baseline: 'GToolkit';
  repository: 'github://feenkcom/gtoolkit/src';
  load.
EpMonitor current enable.

(GtExampleGroup withAll: (Smalltalk gtExamplesContained
	select: [:each | each method package name beginsWith: 'GToolkit'])) do: [ :each | each run ]] timeToRun.

  Transcript crShow: ('loaded gtoolkit in: ', timeToRun printString).