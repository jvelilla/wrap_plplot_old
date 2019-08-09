#----------------------------------------------------------------
# Generated CMake target import file for configuration "Debug".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "PLPLOT::csirocsa" for configuration "Debug"
set_property(TARGET PLPLOT::csirocsa APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(PLPLOT::csirocsa PROPERTIES
  IMPORTED_IMPLIB_DEBUG "C:/Program Files (x86)/plplot/lib/csirocsa.lib"
  IMPORTED_LOCATION_DEBUG "C:/Program Files (x86)/plplot/bin/csirocsa.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS PLPLOT::csirocsa )
list(APPEND _IMPORT_CHECK_FILES_FOR_PLPLOT::csirocsa "C:/Program Files (x86)/plplot/lib/csirocsa.lib" "C:/Program Files (x86)/plplot/bin/csirocsa.dll" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
