
# cmake_policy(SET CMP0015 OLD)

# set(CMAKE_VERBOSE_MAKEFILE on)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_BUILD_TYPE "Release")
set(CMAKE_CXX_FLAGS "-DUSE_SDL_MIXER_AUDIO -DSDL2MIXER_MIDI_NATIVE=ON -DSDL2MIXER_MIDI_FLUIDSYNTH=ON /utf-8")
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


find_package(SDL2 CONFIG REQUIRED)
find_package(SDL2_image CONFIG REQUIRED)
find_package(SDL2_ttf CONFIG REQUIRED)
find_package(libzip CONFIG REQUIRED)
find_package(Iconv)
find_package(unofficial-sqlite3 CONFIG REQUIRED)
find_package(Lua REQUIRED)
find_package(SDL2_mixer CONFIG REQUIRED)
find_package(yaml-cpp CONFIG REQUIRED)
find_package(spdlog CONFIG REQUIRED)
# find_package(opencc CONFIG REQUIRED)

link_directories(${PROJECT_SOURCE_DIR}/local/lib/x64)

set(LINK_LIBRARIES
$<TARGET_NAME_IF_EXISTS:SDL2::SDL2main> 
$<IF:$<TARGET_EXISTS:SDL2::SDL2>,SDL2::SDL2,SDL2::SDL2-static>
$<IF:$<TARGET_EXISTS:SDL2_ttf::SDL2_ttf>,SDL2_ttf::SDL2_ttf,SDL2_ttf::SDL2_ttf-static> 
$<IF:$<TARGET_EXISTS:SDL2_image::SDL2_image>,SDL2_image::SDL2_image,SDL2_image::SDL2_image-static>
$<IF:$<TARGET_EXISTS:SDL2_mixer::SDL2_mixer>,SDL2_mixer::SDL2_mixer,SDL2_mixer::SDL2_mixer-static>
spdlog::spdlog spdlog::spdlog_header_only
${LUA_LIBRARIES}
opencc
unofficial::sqlite3::sqlite3 
yaml-cpp 
libzip::zip
Iconv::Iconv)

add_executable(kys ${SRC_LIST})
target_link_libraries(kys PRIVATE ${LINK_LIBRARIES})

