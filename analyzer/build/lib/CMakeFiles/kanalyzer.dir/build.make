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
include lib/CMakeFiles/kanalyzer.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include lib/CMakeFiles/kanalyzer.dir/compiler_depend.make

# Include the progress variables for this target.
include lib/CMakeFiles/kanalyzer.dir/progress.make

# Include the compile flags for this target's objects.
include lib/CMakeFiles/kanalyzer.dir/flags.make

lib/CMakeFiles/kanalyzer.dir/Common.cc.o: lib/CMakeFiles/kanalyzer.dir/flags.make
lib/CMakeFiles/kanalyzer.dir/Common.cc.o: /home/mukyuuhate/Documents/demo_tool1/analyzer/src/lib/Common.cc
lib/CMakeFiles/kanalyzer.dir/Common.cc.o: lib/CMakeFiles/kanalyzer.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/mukyuuhate/Documents/demo_tool1/analyzer/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object lib/CMakeFiles/kanalyzer.dir/Common.cc.o"
	cd /home/mukyuuhate/Documents/demo_tool1/analyzer/build/lib && /home/mukyuuhate/BufferOverflow_RangeAnalysis/LLVM-10.0.0/build/bin/clang++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT lib/CMakeFiles/kanalyzer.dir/Common.cc.o -MF CMakeFiles/kanalyzer.dir/Common.cc.o.d -o CMakeFiles/kanalyzer.dir/Common.cc.o -c /home/mukyuuhate/Documents/demo_tool1/analyzer/src/lib/Common.cc

lib/CMakeFiles/kanalyzer.dir/Common.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/kanalyzer.dir/Common.cc.i"
	cd /home/mukyuuhate/Documents/demo_tool1/analyzer/build/lib && /home/mukyuuhate/BufferOverflow_RangeAnalysis/LLVM-10.0.0/build/bin/clang++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/mukyuuhate/Documents/demo_tool1/analyzer/src/lib/Common.cc > CMakeFiles/kanalyzer.dir/Common.cc.i

lib/CMakeFiles/kanalyzer.dir/Common.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/kanalyzer.dir/Common.cc.s"
	cd /home/mukyuuhate/Documents/demo_tool1/analyzer/build/lib && /home/mukyuuhate/BufferOverflow_RangeAnalysis/LLVM-10.0.0/build/bin/clang++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/mukyuuhate/Documents/demo_tool1/analyzer/src/lib/Common.cc -o CMakeFiles/kanalyzer.dir/Common.cc.s

lib/CMakeFiles/kanalyzer.dir/Analyzer.cc.o: lib/CMakeFiles/kanalyzer.dir/flags.make
lib/CMakeFiles/kanalyzer.dir/Analyzer.cc.o: /home/mukyuuhate/Documents/demo_tool1/analyzer/src/lib/Analyzer.cc
lib/CMakeFiles/kanalyzer.dir/Analyzer.cc.o: lib/CMakeFiles/kanalyzer.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/mukyuuhate/Documents/demo_tool1/analyzer/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building CXX object lib/CMakeFiles/kanalyzer.dir/Analyzer.cc.o"
	cd /home/mukyuuhate/Documents/demo_tool1/analyzer/build/lib && /home/mukyuuhate/BufferOverflow_RangeAnalysis/LLVM-10.0.0/build/bin/clang++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT lib/CMakeFiles/kanalyzer.dir/Analyzer.cc.o -MF CMakeFiles/kanalyzer.dir/Analyzer.cc.o.d -o CMakeFiles/kanalyzer.dir/Analyzer.cc.o -c /home/mukyuuhate/Documents/demo_tool1/analyzer/src/lib/Analyzer.cc

lib/CMakeFiles/kanalyzer.dir/Analyzer.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/kanalyzer.dir/Analyzer.cc.i"
	cd /home/mukyuuhate/Documents/demo_tool1/analyzer/build/lib && /home/mukyuuhate/BufferOverflow_RangeAnalysis/LLVM-10.0.0/build/bin/clang++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/mukyuuhate/Documents/demo_tool1/analyzer/src/lib/Analyzer.cc > CMakeFiles/kanalyzer.dir/Analyzer.cc.i

lib/CMakeFiles/kanalyzer.dir/Analyzer.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/kanalyzer.dir/Analyzer.cc.s"
	cd /home/mukyuuhate/Documents/demo_tool1/analyzer/build/lib && /home/mukyuuhate/BufferOverflow_RangeAnalysis/LLVM-10.0.0/build/bin/clang++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/mukyuuhate/Documents/demo_tool1/analyzer/src/lib/Analyzer.cc -o CMakeFiles/kanalyzer.dir/Analyzer.cc.s

lib/CMakeFiles/kanalyzer.dir/CallGraph.cc.o: lib/CMakeFiles/kanalyzer.dir/flags.make
lib/CMakeFiles/kanalyzer.dir/CallGraph.cc.o: /home/mukyuuhate/Documents/demo_tool1/analyzer/src/lib/CallGraph.cc
lib/CMakeFiles/kanalyzer.dir/CallGraph.cc.o: lib/CMakeFiles/kanalyzer.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/mukyuuhate/Documents/demo_tool1/analyzer/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building CXX object lib/CMakeFiles/kanalyzer.dir/CallGraph.cc.o"
	cd /home/mukyuuhate/Documents/demo_tool1/analyzer/build/lib && /home/mukyuuhate/BufferOverflow_RangeAnalysis/LLVM-10.0.0/build/bin/clang++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT lib/CMakeFiles/kanalyzer.dir/CallGraph.cc.o -MF CMakeFiles/kanalyzer.dir/CallGraph.cc.o.d -o CMakeFiles/kanalyzer.dir/CallGraph.cc.o -c /home/mukyuuhate/Documents/demo_tool1/analyzer/src/lib/CallGraph.cc

lib/CMakeFiles/kanalyzer.dir/CallGraph.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/kanalyzer.dir/CallGraph.cc.i"
	cd /home/mukyuuhate/Documents/demo_tool1/analyzer/build/lib && /home/mukyuuhate/BufferOverflow_RangeAnalysis/LLVM-10.0.0/build/bin/clang++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/mukyuuhate/Documents/demo_tool1/analyzer/src/lib/CallGraph.cc > CMakeFiles/kanalyzer.dir/CallGraph.cc.i

lib/CMakeFiles/kanalyzer.dir/CallGraph.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/kanalyzer.dir/CallGraph.cc.s"
	cd /home/mukyuuhate/Documents/demo_tool1/analyzer/build/lib && /home/mukyuuhate/BufferOverflow_RangeAnalysis/LLVM-10.0.0/build/bin/clang++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/mukyuuhate/Documents/demo_tool1/analyzer/src/lib/CallGraph.cc -o CMakeFiles/kanalyzer.dir/CallGraph.cc.s

lib/CMakeFiles/kanalyzer.dir/FindErrorFuncs.cc.o: lib/CMakeFiles/kanalyzer.dir/flags.make
lib/CMakeFiles/kanalyzer.dir/FindErrorFuncs.cc.o: /home/mukyuuhate/Documents/demo_tool1/analyzer/src/lib/FindErrorFuncs.cc
lib/CMakeFiles/kanalyzer.dir/FindErrorFuncs.cc.o: lib/CMakeFiles/kanalyzer.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/mukyuuhate/Documents/demo_tool1/analyzer/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Building CXX object lib/CMakeFiles/kanalyzer.dir/FindErrorFuncs.cc.o"
	cd /home/mukyuuhate/Documents/demo_tool1/analyzer/build/lib && /home/mukyuuhate/BufferOverflow_RangeAnalysis/LLVM-10.0.0/build/bin/clang++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT lib/CMakeFiles/kanalyzer.dir/FindErrorFuncs.cc.o -MF CMakeFiles/kanalyzer.dir/FindErrorFuncs.cc.o.d -o CMakeFiles/kanalyzer.dir/FindErrorFuncs.cc.o -c /home/mukyuuhate/Documents/demo_tool1/analyzer/src/lib/FindErrorFuncs.cc

lib/CMakeFiles/kanalyzer.dir/FindErrorFuncs.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/kanalyzer.dir/FindErrorFuncs.cc.i"
	cd /home/mukyuuhate/Documents/demo_tool1/analyzer/build/lib && /home/mukyuuhate/BufferOverflow_RangeAnalysis/LLVM-10.0.0/build/bin/clang++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/mukyuuhate/Documents/demo_tool1/analyzer/src/lib/FindErrorFuncs.cc > CMakeFiles/kanalyzer.dir/FindErrorFuncs.cc.i

lib/CMakeFiles/kanalyzer.dir/FindErrorFuncs.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/kanalyzer.dir/FindErrorFuncs.cc.s"
	cd /home/mukyuuhate/Documents/demo_tool1/analyzer/build/lib && /home/mukyuuhate/BufferOverflow_RangeAnalysis/LLVM-10.0.0/build/bin/clang++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/mukyuuhate/Documents/demo_tool1/analyzer/src/lib/FindErrorFuncs.cc -o CMakeFiles/kanalyzer.dir/FindErrorFuncs.cc.s

# Object files for target kanalyzer
kanalyzer_OBJECTS = \
"CMakeFiles/kanalyzer.dir/Common.cc.o" \
"CMakeFiles/kanalyzer.dir/Analyzer.cc.o" \
"CMakeFiles/kanalyzer.dir/CallGraph.cc.o" \
"CMakeFiles/kanalyzer.dir/FindErrorFuncs.cc.o"

# External object files for target kanalyzer
kanalyzer_EXTERNAL_OBJECTS =

lib/kanalyzer: lib/CMakeFiles/kanalyzer.dir/Common.cc.o
lib/kanalyzer: lib/CMakeFiles/kanalyzer.dir/Analyzer.cc.o
lib/kanalyzer: lib/CMakeFiles/kanalyzer.dir/CallGraph.cc.o
lib/kanalyzer: lib/CMakeFiles/kanalyzer.dir/FindErrorFuncs.cc.o
lib/kanalyzer: lib/CMakeFiles/kanalyzer.dir/build.make
lib/kanalyzer: /home/mukyuuhate/BufferOverflow_RangeAnalysis/LLVM-10.0.0/build/lib/libLLVMAsmParser.a
lib/kanalyzer: /home/mukyuuhate/BufferOverflow_RangeAnalysis/LLVM-10.0.0/build/lib/libLLVMSupport.a
lib/kanalyzer: /home/mukyuuhate/BufferOverflow_RangeAnalysis/LLVM-10.0.0/build/lib/libLLVMCore.a
lib/kanalyzer: /home/mukyuuhate/BufferOverflow_RangeAnalysis/LLVM-10.0.0/build/lib/libLLVMAnalysis.a
lib/kanalyzer: /home/mukyuuhate/BufferOverflow_RangeAnalysis/LLVM-10.0.0/build/lib/libLLVMIRReader.a
lib/kanalyzer: lib/libAnalyzerStatic.a
lib/kanalyzer: /home/mukyuuhate/BufferOverflow_RangeAnalysis/LLVM-10.0.0/build/lib/libLLVMObject.a
lib/kanalyzer: /home/mukyuuhate/BufferOverflow_RangeAnalysis/LLVM-10.0.0/build/lib/libLLVMMCParser.a
lib/kanalyzer: /home/mukyuuhate/BufferOverflow_RangeAnalysis/LLVM-10.0.0/build/lib/libLLVMMC.a
lib/kanalyzer: /home/mukyuuhate/BufferOverflow_RangeAnalysis/LLVM-10.0.0/build/lib/libLLVMDebugInfoCodeView.a
lib/kanalyzer: /home/mukyuuhate/BufferOverflow_RangeAnalysis/LLVM-10.0.0/build/lib/libLLVMDebugInfoMSF.a
lib/kanalyzer: /home/mukyuuhate/BufferOverflow_RangeAnalysis/LLVM-10.0.0/build/lib/libLLVMTextAPI.a
lib/kanalyzer: /home/mukyuuhate/BufferOverflow_RangeAnalysis/LLVM-10.0.0/build/lib/libLLVMProfileData.a
lib/kanalyzer: /home/mukyuuhate/BufferOverflow_RangeAnalysis/LLVM-10.0.0/build/lib/libLLVMAsmParser.a
lib/kanalyzer: /home/mukyuuhate/BufferOverflow_RangeAnalysis/LLVM-10.0.0/build/lib/libLLVMBitReader.a
lib/kanalyzer: /home/mukyuuhate/BufferOverflow_RangeAnalysis/LLVM-10.0.0/build/lib/libLLVMCore.a
lib/kanalyzer: /home/mukyuuhate/BufferOverflow_RangeAnalysis/LLVM-10.0.0/build/lib/libLLVMBinaryFormat.a
lib/kanalyzer: /home/mukyuuhate/BufferOverflow_RangeAnalysis/LLVM-10.0.0/build/lib/libLLVMRemarks.a
lib/kanalyzer: /home/mukyuuhate/BufferOverflow_RangeAnalysis/LLVM-10.0.0/build/lib/libLLVMBitstreamReader.a
lib/kanalyzer: /home/mukyuuhate/BufferOverflow_RangeAnalysis/LLVM-10.0.0/build/lib/libLLVMSupport.a
lib/kanalyzer: /usr/lib/libz3.so
lib/kanalyzer: /home/mukyuuhate/BufferOverflow_RangeAnalysis/LLVM-10.0.0/build/lib/libLLVMDemangle.a
lib/kanalyzer: lib/CMakeFiles/kanalyzer.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/mukyuuhate/Documents/demo_tool1/analyzer/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_5) "Linking CXX executable kanalyzer"
	cd /home/mukyuuhate/Documents/demo_tool1/analyzer/build/lib && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/kanalyzer.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
lib/CMakeFiles/kanalyzer.dir/build: lib/kanalyzer
.PHONY : lib/CMakeFiles/kanalyzer.dir/build

lib/CMakeFiles/kanalyzer.dir/clean:
	cd /home/mukyuuhate/Documents/demo_tool1/analyzer/build/lib && $(CMAKE_COMMAND) -P CMakeFiles/kanalyzer.dir/cmake_clean.cmake
.PHONY : lib/CMakeFiles/kanalyzer.dir/clean

lib/CMakeFiles/kanalyzer.dir/depend:
	cd /home/mukyuuhate/Documents/demo_tool1/analyzer/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/mukyuuhate/Documents/demo_tool1/analyzer/src /home/mukyuuhate/Documents/demo_tool1/analyzer/src/lib /home/mukyuuhate/Documents/demo_tool1/analyzer/build /home/mukyuuhate/Documents/demo_tool1/analyzer/build/lib /home/mukyuuhate/Documents/demo_tool1/analyzer/build/lib/CMakeFiles/kanalyzer.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : lib/CMakeFiles/kanalyzer.dir/depend

