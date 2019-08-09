#----------------------------------------------------------------
# Generated CMake target import file for configuration "Debug".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "PLPLOT::pltek" for configuration "Debug"
set_property(TARGET PLPLOT::pltek APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(PLPLOT::pltek PROPERTIES
  IMPORTED_LOCATION_DEBUG "C:/Program Files (x86)/plplot/bin/pltek.exe"
  )

list(APPEND _IMPORT_CHECK_TARGETS PLPLOT::pltek )
list(APPEND _IMPORT_CHECK_FILES_FOR_PLPLOT::pltek "C:/Program Files (x86)/plplot/bin/pltek.exe" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
