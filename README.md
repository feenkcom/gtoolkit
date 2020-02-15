# Glamorous Toolkit (GT)
Glamorous Toolkit is the moldable development environment. It is a live notebook. It is a flexible search interface. It is a fancy code editor. It is a software analysis platform. It is a data visualization engine. All in one. And it is free and open-source under an MIT license.

Learn more about it at: https://gtoolkit.com. 

## Components

The current repository embodies the second generation of GT and it is comprised of a set of distinct components:
- [Inspector](https://github.com/feenkcom/gtoolkit-inspector): the moldable inspector.
- [Playground](https://github.com/feenkcom/gtoolkit-playground): the moldable playground.
- [Documenter](https://github.com/feenkcom/gtoolkit-documenter): the engine for manipulating live documents.
- [Presenter](https://github.com/feenkcom/gtoolkit-presenter): the engine for live slide-based storytelling.
- [Debugger](https://github.com/feenkcom/gtoolkit-debugger): the moldable debugger for Pharo.
- [Coder](https://github.com/feenkcom/gtoolkit-coder): the moldable coder for Pharo.
- Transcript: a rethinking of the classic Transcript taking advantage of the moldable text editor from Bloc.
- [Visualizer](https://github.com/feenkcom/gtoolkit-visualizer): a set of visualization engines on top of Bloc.
- [Examples](https://github.com/feenkcom/gtoolkit-examples): the engine for example-driven development.
- [Completer](https://github.com/feenkcom/gtoolkit-completer): the moldable completion engine.
- [Phlow](https://github.com/feenkcom/gtoolkit-phlow): the browsing engine.
- [Releaser](https://github.com/feenkcom/gtoolkit-releaser): the engine that allows us to manage and release deeply nested projects.
- [GToolkit4Smacc](https://github.com/feenkcom/gt4smacc): the environment for creating, debugging and testing SmaCC-based parsers.
- [GToolkit4PetitParser2](https://github.com/feenkcom/gt4petitparser2): the environment for creating, debugging and testing PetitParser2-based parsers.
- [GToolkit4Famix3](https://github.com/feenkcom/gt4famix3): the environment and dedicated algorithms for source code analysis.
- [GToolkit4XMLSupport](https://github.com/feenkcom/gt4xmlsupport): the extensions for manipulating and browsing XML.

Glamorous Toolkit is based on graphical stack made of:
- [Sparta](https://github.com/feenkcom/Sparta): the graphical canvas
- [Bloc](https://github.com/feenkcom/Bloc): the graphical framework
- [Brick](https://github.com/feenkcom/Brick): the widget set

# Get the code
## How to get the latest vm and the latest code in one step

MacOSX
```
curl https://raw.githubusercontent.com/feenkcom/gtoolkit/master/scripts/localbuild/mac.sh | bash
```
Linux
```
curl https://raw.githubusercontent.com/feenkcom/gtoolkit/master/scripts/localbuild/linux.sh | bash
```
Windows

Using Powershell cd into `scripts/localbuild` and execute `.\windows.ps1`

## How to load

You can load the whole code in Pharo 8.0 using the following snippet:

```
EpMonitor current disable.
[ 
  Metacello new
    baseline: 'GToolkit';
    repository: 'github://feenkcom/gtoolkit/src';
    load
] ensure: [ EpMonitor current enable ].
#GtWorld asClass open.
```

## How to load the latest development release

You can load the code we're working on in Pharo 8.0 using the following snippet:

```
EpMonitor current disable.
[ 
  Metacello new
    baseline: 'GToolkit';
    repository: 'github://feenkcom/gtoolkit:release/src';
    load
] ensure: [ EpMonitor current enable ].
#GtWorld asClass open.
```
## License

See [LICENSE](LICENSE).
