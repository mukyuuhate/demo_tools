set (AnalyzerSourceCodes
	Common.hh
	Common.cc
	Analyzer.hh
	Analyzer.cc
	CallGraph.hh
	CallGraph.cc
	FindErrorFuncs.cc
	FindErrorFuncs.hh
	)

file(COPY configs/ DESTINATION configs)

set(CMAKE_MACOSX_RPATH 0)

# Build libraries.
add_library (AnalyzerObj OBJECT ${AnalyzerSourceCodes})
add_library (Analyzer SHARED $<TARGET_OBJECTS:AnalyzerObj>)
add_library (AnalyzerStatic STATIC $<TARGET_OBJECTS:AnalyzerObj>)

# Build executable.
set (EXECUTABLE_OUTPUT_PATH ${ANALYZER_BINARY_DIR})
link_directories (${ANALYZER_BINARY_DIR}/lib)
add_executable(kanalyzer ${AnalyzerSourceCodes})
target_link_libraries(kanalyzer
  LLVMAsmParser
  LLVMSupport
  LLVMCore
  LLVMAnalysis
  LLVMIRReader
  AnalyzerStatic
  ${Z3_LIBRARIES})

