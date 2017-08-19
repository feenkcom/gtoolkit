# gtoolkit
The Glamorous Toolkit (GT) is the moldable IDE of Pharo.

The current repository embodies the second generation of GT that is based on the [Bloc project](https://github.com/pharo-graphics/Bloc).

## How to load

You can load the code in both Pharo 6.1 and in Pharo 7.0 using the following snippet:

```
Iceberg enableMetacelloIntegration: true.
Metacello new
   baseline: 'GToolkit';
   repository: 'github://feenkcom/gtoolkit/src';
	load.
```
