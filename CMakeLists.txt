cmake_minimum_required(VERSION 3.6)

project(kys)
# cmake_policy(SET CMP0015 OLD)

# set(CMAKE_VERBOSE_MAKEFILE on)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_FLAGS "-DUSE_SDL_MIXER_AUDIO")
# set(CMAKE_CXX_COMPILER $ENV{CXX})
# set(CMAKE_CXX_FLAGS "-O2 -std=c++17 -pthread -DNDEBUG -DUSE_SDL_MIXER_AUDIO")

include_directories(${PROJECT_SOURCE_DIR}/include)
include_directories(${PROJECT_SOURCE_DIR}/mlcc)
include_directories(${PROJECT_SOURCE_DIR}/others)
include_directories(${PROJECT_SOURCE_DIR}/local/include)

file(GLOB SRC_LIST
    ${PROJECT_SOURCE_DIR}/src/*.cpp
    ${PROJECT_SOURCE_DIR}/mlcc/strfunc.cpp
    ${PROJECT_SOURCE_DIR}/mlcc/filefunc.cpp
    ${PROJECT_SOURCE_DIR}/mlcc/PotConv.cpp
    ${PROJECT_SOURCE_DIR}/others/Hanz2Piny.cpp
)

set(LINK_LIBRARIES SDL2 SDL2_ttf SDL2_image SDL2_mixer SDL2main lua5.4 opencc sqlite3 yaml-cpp zip)
if (APPLE)
    set(LINK_LIBRARIES ${LINK_LIBRARIES} iconv)
endif ()

add_executable(kys ${SRC_LIST})
target_link_libraries(kys ${LINK_LIBRARIES})
