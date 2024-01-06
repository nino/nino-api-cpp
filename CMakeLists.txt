cmake_minimum_required(VERSION 3.22.0)
project(nino_api_cpp)
add_compile_options(-std=c++20)
add_compile_options(-Wall)
add_compile_options(-Wextra)
add_compile_options(-Wpedantic)
add_compile_options(-Werror)
add_compile_options(-Wno-unused-parameter)
add_compile_options(-Wno-unused-variable)
add_compile_options(-Wno-unused-function)
add_compile_options(-Wno-unused-but-set-variable)
add_compile_options(-Wno-unused-but-set-parameter)
add_compile_options(-Wno-missing-field-initializers)
add_compile_options(-Wno-missing-braces)
add_compile_options(-Wno-unknown-pragmas)
add_compile_options(-Wno-strict-aliasing)
add_compile_options(-Wno-implicit-fallthrough)
add_compile_options(-Wno-sign-compare)
add_compile_options(-Wno-implicit-int-float-conversion)
add_compile_options(-Wno-implicit-float-conversion)
add_compile_options(-Wno-enum-compare-switch)
add_compile_options(-Wno-enum-compare)
add_compile_options(-Wno-enum-compare-switch)

include(FetchContent)
include(ExternalProject)

FetchContent_Declare(
  libmicrohttpd
  GIT_REPOSITORY https://git.gnunet.org/libmicrohttpd.git
  GIT_TAG        master # It's usually better to pin a specific commit or version tag
)

FetchContent_Declare(
  pugixml
  GIT_REPOSITORY https://github.com/zeux/pugixml
  GIT_TAG        master # It's usually better to pin a specific commit or version tag
)

FetchContent_MakeAvailable(libmicrohttpd)
FetchContent_MakeAvailable(pugixml)
# FetchContent_MakeAvailable(httpserver)

# FetchContent_Declare(
#   httpserver
#   GIT_REPOSITORY https://github.com/etr/libhttpserver
#   GIT_TAG        master # It's usually better to pin a specific commit or version tag
# )

ExternalProject_Add(libhttpserver
	DEPENDS libmicrohttpd
	PREFIX sysroot-prefix
	GIT_REPOSITORY https://github.com/etr/libhttpserver.git
	GIT_TAG master
	UPDATE_DISCONNECTED 1
	CONFIGURE_COMMAND <SOURCE_DIR>/configure --prefix=<INSTALL_DIR>
		--$<IF:$<CONFIG:DEBUG>,enable,disable>-debug --disable-examples
	TEST_COMMAND make check
	TEST_EXCLUDE_FROM_MAIN 1
	STEP_TARGETS update install test
)

ExternalProject_Get_Property(libhttpserver SOURCE_DIR)
ExternalProject_Add_Step(libhttpserver bootstrap
	COMMAND				./bootstrap
	DEPENDEES			update
	DEPENDERS			configure
	BYPRODUCTS			<SOURCE_DIR>/configure
	WORKING_DIRECTORY	<SOURCE_DIR>
)
# FetchContent_Declare(
#   seastar
#   GIT_REPOSITORY https://github.com/scylladb/seastar
#   GIT_TAG        master # It's usually better to pin a specific commit or version tag
# )



find_package(OpenSSL REQUIRED)


add_executable(api source/main.cpp source/last_year.cpp source/http.cpp)

target_link_libraries(api PRIVATE microhttpd pugixml httpserver)
target_include_directories(api PRIVATE ${OPENSSL_INCLUDE_DIR})
target_link_libraries(api PRIVATE OpenSSL::SSL OpenSSL::Crypto)
