add_executable(nn nn.cpp)
target_compile_features(nn PRIVATE cxx_decltype_auto cxx_auto_type)
target_link_libraries(nn gflags glog ${Boost_LIBRARIES} ${CMAKE_THREAD_LIBS_INIT})
