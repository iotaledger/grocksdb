#
# CMake Toolchain file for crosscompiling on WINDOWS.
#
# Target operating system name.
set(CMAKE_SYSTEM_NAME Windows)
set(CMAKE_SYSTEM_PROCESSOR x86_64)
set(CMAKE_CROSSCOMPILING TRUE)

# Name of C compiler.
set(CMAKE_C_COMPILER "/usr/bin/x86_64-w64-mingw32-gcc-posix")
set(CMAKE_CXX_COMPILER "/usr/bin/x86_64-w64-mingw32-g++-posix")

# Where to look for the target environment. (More paths can be added here)
#set(CMAKE_FIND_ROOT_PATH /usr/x86_64-w64-mingw32)
set(CMAKE_FIND_ROOT_PATH $ENV{DIST_DIR})
set(CMAKE_INCLUDE_PATH  /usr/lib/gcc/x86_64-w64-mingw32/8.3-posix/include)
set(CMAKE_LIBRARY_PATH  /usr/lib/gcc/x86_64-w64-mingw32/8.3-posix)
set(CMAKE_PROGRAM_PATH  /usr/x86_64-w64-mingw32/bin)

# Adjust the default behavior of the FIND_XXX() commands:
# search programs in the host environment only.
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)

# Search headers and libraries in the target environment only.
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)
