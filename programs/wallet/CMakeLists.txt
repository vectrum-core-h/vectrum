add_executable( ${WALLET_EXECUTABLE_NAME} main.cpp )
if( UNIX AND NOT APPLE )
  set(rt_library rt )
endif()

find_package( Gperftools QUIET )
if( GPERFTOOLS_FOUND )
    message( STATUS "Found gperftools; compiling ${WALLET_EXECUTABLE_NAME} with TCMalloc")
    list( APPEND PLATFORM_SPECIFIC_LIBS tcmalloc )
endif()

configure_file(config.hpp.in config.hpp ESCAPE_QUOTES)

target_link_libraries( ${WALLET_EXECUTABLE_NAME}
        PRIVATE appbase version
        PRIVATE wallet_api_plugin wallet_plugin
        PRIVATE http_plugin
        PRIVATE eosio_chain fc ${CMAKE_DL_LIBS} ${PLATFORM_SPECIFIC_LIBS} )
target_include_directories(${WALLET_EXECUTABLE_NAME} PUBLIC ${CMAKE_CURRENT_BINARY_DIR})

mas_sign(${WALLET_EXECUTABLE_NAME})

copy_bin( ${WALLET_EXECUTABLE_NAME} )
install( TARGETS
   ${WALLET_EXECUTABLE_NAME} RUNTIME DESTINATION ${CMAKE_INSTALL_FULL_BINDIR} COMPONENT base
)
