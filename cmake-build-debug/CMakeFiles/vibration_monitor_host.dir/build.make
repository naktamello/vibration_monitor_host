# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.13

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /home/camel/programs/clion-2018.3/bin/cmake/linux/bin/cmake

# The command to remove a file.
RM = /home/camel/programs/clion-2018.3/bin/cmake/linux/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/camel/programs/cpp_projects/vibration_monitor_host

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/camel/programs/cpp_projects/vibration_monitor_host/cmake-build-debug

# Include any dependencies generated for this target.
include CMakeFiles/vibration_monitor_host.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/vibration_monitor_host.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/vibration_monitor_host.dir/flags.make

CMakeFiles/vibration_monitor_host.dir/main.cpp.o: CMakeFiles/vibration_monitor_host.dir/flags.make
CMakeFiles/vibration_monitor_host.dir/main.cpp.o: ../main.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/camel/programs/cpp_projects/vibration_monitor_host/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/vibration_monitor_host.dir/main.cpp.o"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/vibration_monitor_host.dir/main.cpp.o -c /home/camel/programs/cpp_projects/vibration_monitor_host/main.cpp

CMakeFiles/vibration_monitor_host.dir/main.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/vibration_monitor_host.dir/main.cpp.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/camel/programs/cpp_projects/vibration_monitor_host/main.cpp > CMakeFiles/vibration_monitor_host.dir/main.cpp.i

CMakeFiles/vibration_monitor_host.dir/main.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/vibration_monitor_host.dir/main.cpp.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/camel/programs/cpp_projects/vibration_monitor_host/main.cpp -o CMakeFiles/vibration_monitor_host.dir/main.cpp.s

# Object files for target vibration_monitor_host
vibration_monitor_host_OBJECTS = \
"CMakeFiles/vibration_monitor_host.dir/main.cpp.o"

# External object files for target vibration_monitor_host
vibration_monitor_host_EXTERNAL_OBJECTS =

vibration_monitor_host: CMakeFiles/vibration_monitor_host.dir/main.cpp.o
vibration_monitor_host: CMakeFiles/vibration_monitor_host.dir/build.make
vibration_monitor_host: CMakeFiles/vibration_monitor_host.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/camel/programs/cpp_projects/vibration_monitor_host/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable vibration_monitor_host"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/vibration_monitor_host.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/vibration_monitor_host.dir/build: vibration_monitor_host

.PHONY : CMakeFiles/vibration_monitor_host.dir/build

CMakeFiles/vibration_monitor_host.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/vibration_monitor_host.dir/cmake_clean.cmake
.PHONY : CMakeFiles/vibration_monitor_host.dir/clean

CMakeFiles/vibration_monitor_host.dir/depend:
	cd /home/camel/programs/cpp_projects/vibration_monitor_host/cmake-build-debug && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/camel/programs/cpp_projects/vibration_monitor_host /home/camel/programs/cpp_projects/vibration_monitor_host /home/camel/programs/cpp_projects/vibration_monitor_host/cmake-build-debug /home/camel/programs/cpp_projects/vibration_monitor_host/cmake-build-debug /home/camel/programs/cpp_projects/vibration_monitor_host/cmake-build-debug/CMakeFiles/vibration_monitor_host.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/vibration_monitor_host.dir/depend

