I handle executor scripts that includes code to uxecute.

This is how the Pillar definition looks like:

```
[[[executor
Metacello new
   baseline: 'FeenkXd';
   repository: 'github://feenkcom/xd/src';
   load.
]]]
```

This is how it looks like in Bloc (you need Bloc view enabled):

[[[executor
Metacello new
   baseline: 'FeenkXd';
   repository: 'github://feenkcom/xd/src';
   load.
]]]
