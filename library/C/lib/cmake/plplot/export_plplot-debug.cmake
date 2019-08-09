#----------------------------------------------------------------
# Generated CMake target import file for configuration "Debug".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "PLPLOT::plplot" for configuration "Debug"
set_property(TARGET PLPLOT::plplot APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(PLPLOT::plplot PROPERTIES
  IMPORTED_IMPLIB_DEBUG "C:/Program Files (x86)/plplot/lib/plplot.lib"
  IMPORTED_LOCATION_DEBUG "C:/Program Files (x86)/plplot/bin/plplot.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS PLPLOT::plplot )
list(APPEND _IMPORT_CHECK_FILES_FOR_PLPLOT::plplot "C:/Program Files (x86)/plplot/lib/plplot.lib" "C:/Program Files (x86)/plplot/bin/plplot.dll" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
