cmake_minimum_required(VERSION 3.13)
project(vibration_monitor_host)

set(CMAKE_CXX_STANDARD 14)

add_executable(vibration_monitor_host main.cpp)
TARGET_LINK_LIBRARIES(vibration_monitor_host usb-1.0 boost_system boost_thread boost_date_time)