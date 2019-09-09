# Eiffel Plplot Library

## Wrapped using [WrapC](https://github.com/eiffel-wrap-c/WrapC) tool.

A library that enable to use plplot from Eiffel code. Currently only working on Windows and tested with
version Plplot [5.15.0](https://sourceforge.net/projects/plplot/files/plplot/5.15.0%20Source/)

## Installation

### Windows

Tested with Microsoft VisualC compiler on 64 bits. 
```
  git clone https://github.com/eiffel-wrap-c/wrap_plplot wrap_plplot
  cd wrap_plplot
```  

### Building Plplot
Look at [Building_PLplot](https://sourceforge.net/p/plplot/wiki/Building_PLplot/) to obtain generic build instruction and then [build Plplot with VisualStudio](https://sourceforge.net/p/plplot/wiki/Configure_PLplot_for_the_Visual_Studio_IDE/)

Then setup the following environment variables
```
  PLPLOT_HOME :  path to plpot home directory: example `C:\Program Files (x86)\plplot`.
  PLPLOT_DRV_DIR: path to plplot drivers directory: example `%PLPLOT_HOME%\lib\plplot5.15.0\drivers`.
  PLPLOT_LIB: paht to plot library directory: example: `%PLPLOT_HOME%\share\plplot5.15.0`.
```

