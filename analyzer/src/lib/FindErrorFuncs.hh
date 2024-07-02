#ifndef FINDERRORFUNCS_H
#define FINDERRORFUNCS_H

#include "Analyzer.hh"

typedef std::set<string> UseSet;

struct ErrorJudge {
    int free_num = 0;				       // 资源释放函数调用次数
    int unlock_num = 0;                    // unlock函数调用次数
    int err_handle_num = 0;                // 已确认错误处理函数调用次数
    int err_print_num = 0;                 // 错误信息打印次数
    int self_if_in_crix = 0;		       // 函数自身是否在crix列表中
    int exit_num = 0;		               // 进程中断函数调用

    int err_return_num = 0;                // 是否返回错误代码
    int if_caller_in_security_check = 0;   // 函数调用点是否存在安全检查

    int total_lines = 0;				   // 函数的源代码行数
    int interrupted_dataflow_num = 0;	   // caller中断数据流次数
};

struct FunctionInfo{
    UseSet define;
    UseSet use;
    ErrorJudge err_info;
};

typedef std::map<std::string, FunctionInfo> FuncUseMap;

class FindErrorFuncsPass : public IterativeModulePass {
private:
    FuncUseMap func_use_map;

    float check_sum(FunctionInfo fb);

public:
    FindErrorFuncsPass(GlobalContext *Ctx_)
        : IterativeModulePass(Ctx_, "Find error funcs") {}
    virtual bool doInitialization(llvm::Module *);
    virtual bool doFinalization(llvm::Module *);
    virtual bool doModulePass(llvm::Module *);

    bool is_error_func(string func_name);
    void dump_func_use_map();

    std::string remove_extra_backslash(std::string line);
    void read_source_code(string path);

    ErrorJudge judge_function_body(Function* F, int depth);
    void judge_function_caller(CallInst *CI, FunctionInfo& fb);
    string read_line(string filename, int line);

    Value* findOriginOfPointer(Value* pointer);
};

#endif