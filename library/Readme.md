# How to generate the code?

## Requirements
You need to have a binary version of WrapC tool and for plplot you will need to compile the escript tool (tools/escript) and be able to
execute them form the library folder.

Before to regenerated the generated code, remove the folder generated_wrapper folder.

## Using WrapC with geant
$LIB_PATH is the path to the library folder where you checkout the wrap_plplot library.

### Wrap plplot library

Go to the $LIB_PATH/library

```
    geant wrap_c  -- Wrap C plplot library and generate the code under the folder generated_wrapper
```

### Postprocessing the generated code.
```
    escript.exe   -- post proccessing to rename and update some generated code specific for this C library.
```    

### Compile the C library
 ```
    geant compile -- Build the C library, in this case generate the eif_plplot.lib
  ```
  
## Using WrapC without geant
  
$LIB_PATH is the path to the library folder where you checkout the wrap_plplot library.
At the moment the teol require --output-dir and --full-header to be full paths.
  
### Wrap plplot library  
  ```
    wrap_c --verbose --output-dir=$LIB_PATH/library/generated_wrapper --full-header=$LIB_PATH/library/C/include/plplot.h config.xml
  ```
  
### Postprocessing the generated code.
```
   escript.exe   -- post proccessing to rename and update some generated code specific for this C library.
```    

### Compile the C library
```
  cd generated_wrapper\c\src
  finish_freezing -library
```

  
