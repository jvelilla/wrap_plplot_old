#----------------------------------------------------------------
# Generated CMake target import file for configuration "Debug".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "PLPLOT::qsastime" for configuration "Debug"
set_property(TARGET PLPLOT::qsastime APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(PLPLOT::qsastime PROPERTIES
  IMPORTED_IMPLIB_DEBUG "C:/Program Files (x86)/plplot/lib/qsastime.lib"
  IMPORTED_LOCATION_DEBUG "C:/Program Files (x86)/plplot/bin/qsastime.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS PLPLOT::qsastime )
list(APPEND _IMPORT_CHECK_FILES_FOR_PLPLOT::qsastime "C:/Program Files (x86)/plplot/lib/qsastime.lib" "C:/Program Files (x86)/plplot/bin/qsastime.dll" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
