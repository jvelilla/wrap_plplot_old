#----------------------------------------------------------------
# Generated CMake target import file for configuration "Debug".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "PLPLOT::wingcc" for configuration "Debug"
set_property(TARGET PLPLOT::wingcc APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(PLPLOT::wingcc PROPERTIES
  IMPORTED_COMMON_LANGUAGE_RUNTIME_DEBUG ""
  IMPORTED_LOCATION_DEBUG "C:/Program Files (x86)/plplot/lib/plplot5.15.0/drivers/wingcc.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS PLPLOT::wingcc )
list(APPEND _IMPORT_CHECK_FILES_FOR_PLPLOT::wingcc "C:/Program Files (x86)/plplot/lib/plplot5.15.0/drivers/wingcc.dll" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
