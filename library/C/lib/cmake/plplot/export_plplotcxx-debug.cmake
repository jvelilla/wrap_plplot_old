#----------------------------------------------------------------
# Generated CMake target import file for configuration "Debug".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "PLPLOT::plplotcxx" for configuration "Debug"
set_property(TARGET PLPLOT::plplotcxx APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(PLPLOT::plplotcxx PROPERTIES
  IMPORTED_IMPLIB_DEBUG "C:/Program Files (x86)/plplot/lib/plplotcxx.lib"
  IMPORTED_LOCATION_DEBUG "C:/Program Files (x86)/plplot/bin/plplotcxx.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS PLPLOT::plplotcxx )
list(APPEND _IMPORT_CHECK_FILES_FOR_PLPLOT::plplotcxx "C:/Program Files (x86)/plplot/lib/plplotcxx.lib" "C:/Program Files (x86)/plplot/bin/plplotcxx.dll" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
