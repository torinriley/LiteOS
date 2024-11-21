cmake_minimum_required(VERSION 3.20)
project(MyLightweightOS LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

add_executable(MyLightweightOS main.cpp
        src/kernel.cpp
        src/kernel.h
)
