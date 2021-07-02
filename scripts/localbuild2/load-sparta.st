EpMonitor disableDuring: [
    Iceberg remoteTypeSelector: #httpsUrl.

    Metacello new
       baseline: 'GToolkitClipboard';
       repository: 'github://feenkcom/gtoolkit-clipboard/src';
       load.

	Metacello new
        baseline: 'Sparta';
        repository: 'github://feenkcom/sparta/src';
        load.
].

Smalltalk snapshot: true andQuit: false.