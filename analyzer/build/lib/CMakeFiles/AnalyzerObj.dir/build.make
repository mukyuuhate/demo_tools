# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.22

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/mukyuuhate/Documents/demo_tool1/analyzer/src

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/mukyuuhate/Documents/demo_tool1/analyzer/build

# Include any dependencies generated for this target.
include lib/CMakeFiles/AnalyzerObj.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include lib/CMakeFiles/AnalyzerObj.dir/compiler_depend.make

# Include the progress variables for this target.
include lib/CMakeFiles/AnalyzerObj.dir/progress.make

# Include the compile flags for this target's objects.
include lib/CMakeFiles/AnalyzerObj.dir/flags.make

lib/CMakeFiles/AnalyzerObj.dir/Common.cc.o: lib/CMakeFiles/AnalyzerObj.dir/flags.make
lib/CMakeFiles/AnalyzerObj.dir/Common.cc.o: /home/mukyuuhate/Documents/demo_tool1/analyzer/src/lib/Common.cc
lib/CMakeFiles/AnalyzerObj.dir/Common.cc.o: lib/CMakeFiles/AnalyzerObj.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/mukyuuhate/Documents/demo_tool1/analyzer/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object lib/CMakeFiles/AnalyzerObj.dir/Common.cc.o"
	cd /home/mukyuuhate/Documents/demo_tool1/analyzer/build/lib && /home/mukyuuhate/BufferOverflow_RangeAnalysis/LLVM-10.0.0/build/bin/clang++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT lib/CMakeFiles/AnalyzerObj.dir/Common.cc.o -MF CMakeFiles/AnalyzerObj.dir/Common.cc.o.d -o CMakeFiles/AnalyzerObj.dir/Common.cc.o -c /home/mukyuuhate/Documents/demo_tool1/analyzer/src/lib/Common.cc

lib/CMakeFiles/AnalyzerObj.dir/Common.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/AnalyzerObj.dir/Common.cc.i"
	cd /home/mukyuuhate/Documents/demo_tool1/analyzer/build/lib && /home/mukyuuhate/BufferOverflow_RangeAnalysis/LLVM-10.0.0/build/bin/clang++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/mukyuuhate/Documents/demo_tool1/analyzer/src/lib/Common.cc > CMakeFiles/AnalyzerObj.dir/Common.cc.i

lib/CMakeFiles/AnalyzerObj.dir/Common.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/AnalyzerObj.dir/Common.cc.s"
	cd /home/mukyuuhate/Documents/demo_tool1/analyzer/build/lib && /home/mukyuuhate/BufferOverflow_RangeAnalysis/LLVM-10.0.0/build/bin/clang++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/mukyuuhate/Documents/demo_tool1/analyzer/src/lib/Common.cc -o CMakeFiles/AnalyzerObj.dir/Common.cc.s

lib/CMakeFiles/AnalyzerObj.dir/Analyzer.cc.o: lib/CMakeFiles/AnalyzerObj.dir/flags.make
lib/CMakeFiles/AnalyzerObj.dir/Analyzer.cc.o: /home/mukyuuhate/Documents/demo_tool1/analyzer/src/lib/Analyzer.cc
lib/CMakeFiles/AnalyzerObj.dir/Analyzer.cc.o: lib/CMakeFiles/AnalyzerObj.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/mukyuuhate/Documents/demo_tool1/analyzer/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building CXX object lib/CMakeFiles/AnalyzerObj.dir/Analyzer.cc.o"
	cd /home/mukyuuhate/Documents/demo_tool1/analyzer/build/lib && /home/mukyuuhate/BufferOverflow_RangeAnalysis/LLVM-10.0.0/build/bin/clang++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT lib/CMakeFiles/AnalyzerObj.dir/Analyzer.cc.o -MF CMakeFiles/AnalyzerObj.dir/Analyzer.cc.o.d -o CMakeFiles/AnalyzerObj.dir/Analyzer.cc.o -c /home/mukyuuhate/Documents/demo_tool1/analyzer/src/lib/Analyzer.cc

lib/CMakeFiles/AnalyzerObj.dir/Analyzer.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/AnalyzerObj.dir/Analyzer.cc.i"
	cd /home/mukyuuhate/Documents/demo_tool1/analyzer/build/lib && /home/mukyuuhate/BufferOverflow_RangeAnalysis/LLVM-10.0.0/build/bin/clang++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/mukyuuhate/Documents/demo_tool1/analyzer/src/lib/Analyzer.cc > CMakeFiles/AnalyzerObj.dir/Analyzer.cc.i

lib/CMakeFiles/AnalyzerObj.dir/Analyzer.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/AnalyzerObj.dir/Analyzer.cc.s"
	cd /home/mukyuuhate/Documents/demo_tool1/analyzer/build/lib && /home/mukyuuhate/BufferOverflow_RangeAnalysis/LLVM-10.0.0/build/bin/clang++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/mukyuuhate/Documents/demo_tool1/analyzer/src/lib/Analyzer.cc -o CMakeFiles/AnalyzerObj.dir/Analyzer.cc.s

lib/CMakeFiles/AnalyzerObj.dir/CallGraph.cc.o: lib/CMakeFiles/AnalyzerObj.dir/flags.make
lib/CMakeFiles/AnalyzerObj.dir/CallGraph.cc.o: /home/mukyuuhate/Documents/demo_tool1/analyzer/src/lib/CallGraph.cc
lib/CMakeFiles/AnalyzerObj.dir/CallGraph.cc.o: lib/CMakeFiles/AnalyzerObj.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/mukyuuhate/Documents/demo_tool1/analyzer/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building CXX object lib/CMakeFiles/AnalyzerObj.dir/CallGraph.cc.o"
	cd /home/mukyuuhate/Documents/demo_tool1/analyzer/build/lib && /home/mukyuuhate/BufferOverflow_RangeAnalysis/LLVM-10.0.0/build/bin/clang++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT lib/CMakeFiles/AnalyzerObj.dir/CallGraph.cc.o -MF CMakeFiles/AnalyzerObj.dir/CallGraph.cc.o.d -o CMakeFiles/AnalyzerObj.dir/CallGraph.cc.o -c /home/mukyuuhate/Documents/demo_tool1/analyzer/src/lib/CallGraph.cc

lib/CMakeFiles/AnalyzerObj.dir/CallGraph.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/AnalyzerObj.dir/CallGraph.cc.i"
	cd /home/mukyuuhate/Documents/demo_tool1/analyzer/build/lib && /home/mukyuuhate/BufferOverflow_RangeAnalysis/LLVM-10.0.0/build/bin/clang++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/mukyuuhate/Documents/demo_tool1/analyzer/src/lib/CallGraph.cc > CMakeFiles/AnalyzerObj.dir/CallGraph.cc.i

lib/CMakeFiles/AnalyzerObj.dir/CallGraph.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/AnalyzerObj.dir/CallGraph.cc.s"
	cd /home/mukyuuhate/Documents/demo_tool1/analyzer/build/lib && /home/mukyuuhate/BufferOverflow_RangeAnalysis/LLVM-10.0.0/build/bin/clang++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/mukyuuhate/Documents/demo_tool1/analyzer/src/lib/CallGraph.cc -o CMakeFiles/AnalyzerObj.dir/CallGraph.cc.s

lib/CMakeFiles/AnalyzerObj.dir/FindErrorFuncs.cc.o: lib/CMakeFiles/AnalyzerObj.dir/flags.make
lib/CMakeFiles/AnalyzerObj.dir/FindErrorFuncs.cc.o: /home/mukyuuhate/Documents/demo_tool1/analyzer/src/lib/FindErrorFuncs.cc
lib/CMakeFiles/AnalyzerObj.dir/FindErrorFuncs.cc.o: lib/CMakeFiles/AnalyzerObj.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/mukyuuhate/Documents/demo_tool1/analyzer/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Building CXX object lib/CMakeFiles/AnalyzerObj.dir/FindErrorFuncs.cc.o"
	cd /home/mukyuuhate/Documents/demo_tool1/analyzer/build/lib && /home/mukyuuhate/BufferOverflow_RangeAnalysis/LLVM-10.0.0/build/bin/clang++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT lib/CMakeFiles/AnalyzerObj.dir/FindErrorFuncs.cc.o -MF CMakeFiles/AnalyzerObj.dir/FindErrorFuncs.cc.o.d -o CMakeFiles/AnalyzerObj.dir/FindErrorFuncs.cc.o -c /home/mukyuuhate/Documents/demo_tool1/analyzer/src/lib/FindErrorFuncs.cc

lib/CMakeFiles/AnalyzerObj.dir/FindErrorFuncs.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/AnalyzerObj.dir/FindErrorFuncs.cc.i"
	cd /home/mukyuuhate/Documents/demo_tool1/analyzer/build/lib && /home/mukyuuhate/BufferOverflow_RangeAnalysis/LLVM-10.0.0/build/bin/clang++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/mukyuuhate/Documents/demo_tool1/analyzer/src/lib/FindErrorFuncs.cc > CMakeFiles/AnalyzerObj.dir/FindErrorFuncs.cc.i

lib/CMakeFiles/AnalyzerObj.dir/FindErrorFuncs.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/AnalyzerObj.dir/FindErrorFuncs.cc.s"
	cd /home/mukyuuhate/Documents/demo_tool1/analyzer/build/lib && /home/mukyuuhate/BufferOverflow_RangeAnalysis/LLVM-10.0.0/build/bin/clang++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/mukyuuhate/Documents/demo_tool1/analyzer/src/lib/FindErrorFuncs.cc -o CMakeFiles/AnalyzerObj.dir/FindErrorFuncs.cc.s

AnalyzerObj: lib/CMakeFiles/AnalyzerObj.dir/Common.cc.o
AnalyzerObj: lib/CMakeFiles/AnalyzerObj.dir/Analyzer.cc.o
AnalyzerObj: lib/CMakeFiles/AnalyzerObj.dir/CallGraph.cc.o
AnalyzerObj: lib/CMakeFiles/AnalyzerObj.dir/FindErrorFuncs.cc.o
AnalyzerObj: lib/CMakeFiles/AnalyzerObj.dir/build.make
.PHONY : AnalyzerObj

# Rule to build all files generated by this target.
lib/CMakeFiles/AnalyzerObj.dir/build: AnalyzerObj
.PHONY : lib/CMakeFiles/AnalyzerObj.dir/build

lib/CMakeFiles/AnalyzerObj.dir/clean:
	cd /home/mukyuuhate/Documents/demo_tool1/analyzer/build/lib && $(CMAKE_COMMAND) -P CMakeFiles/AnalyzerObj.dir/cmake_clean.cmake
.PHONY : lib/CMakeFiles/AnalyzerObj.dir/clean

lib/CMakeFiles/AnalyzerObj.dir/depend:
	cd /home/mukyuuhate/Documents/demo_tool1/analyzer/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/mukyuuhate/Documents/demo_tool1/analyzer/src /home/mukyuuhate/Documents/demo_tool1/analyzer/src/lib /home/mukyuuhate/Documents/demo_tool1/analyzer/build /home/mukyuuhate/Documents/demo_tool1/analyzer/build/lib /home/mukyuuhate/Documents/demo_tool1/analyzer/build/lib/CMakeFiles/AnalyzerObj.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : lib/CMakeFiles/AnalyzerObj.dir/depend

