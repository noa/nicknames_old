cmake_minimum_required(VERSION 3.0)

# Project name
project(nicknames)

# Project version
set (nn_VERSION_MAJOR 1)
set (nn_VERSION_MINOR 0)

# CXX Standard
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Compile flags
add_definitions(-Wfatal-errors)

# Build type
if( NOT CMAKE_BUILD_TYPE )
  set( CMAKE_BUILD_TYPE Release CACHE STRING
       "Choose the type of build, options are: None Debug Release RelWithDebInfo MinSizeRel."
       FORCE )
endif()

# Custom modules
set (CMAKE_MODULE_PATH "${parser_SOURCE_DIR}/cmake")

find_package(GSL REQUIRED)

find_package(Boost 1.60.0 COMPONENTS
  thread
  iostreams
  serialization
  date_time
  system
  timer
  filesystem
  REQUIRED)

message(STATUS "Boost root: ${BOOST_ROOT}")

# Thread support
find_package( OpenMP )
find_package( Threads )

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${OpenMP_C_FLAGS}")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${OpenMP_CXX_FLAGS}")

add_subdirectory(gflags)
set(WITH_GFLAGS OFF CACHE BOOL "build with gflags")
add_subdirectory(glog)
add_subdirectory(googletest)

set(gflags_DIR "${PROJECT_SOURCE_DIR}/gflags")
enable_testing()

# Set include and link directories
include_directories(
  ${CMAKE_SOURCE_DIR}
  ${GSL_INCLUDE_DIRS}
  ${Boost_INCLUDE_DIRS}
  ${GFLAGS_INCLUDE_DIRS}
  ${GLOG_INCLUDE_DIRS}
  )

# Set link directories
link_directories(${Boost_LIBRARY_DIRS})

# Set subdirectories
include_directories(src)
add_subdirectory(src)
