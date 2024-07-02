#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/CFG.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/InstrTypes.h"
#include "llvm/IR/Instruction.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Transforms/Utils/BasicBlockUtils.h"
#include <llvm/ADT/StringExtras.h>
#include <llvm/IR/Constants.h>
#include <llvm/IR/DebugInfo.h>
#include <llvm/IR/InstIterator.h>
#include <llvm/IR/Instructions.h>
#include <llvm/IR/LegacyPassManager.h>
#include <llvm/IR/Module.h>
#include <llvm/Pass.h>
#include <llvm/Support/Debug.h>

#include <fstream>
#include <iostream>
#include <sstream>
#include <regex>
#include <string>

#include "FindErrorFuncs.hh"

using namespace llvm;

std::vector<std::string> crix_list;

std::vector<std::string> free_list;


bool FindErrorFuncsPass::is_error_func(string func_name) {
    std::string lowercaseInput = func_name;
    std::transform(lowercaseInput.begin(), lowercaseInput.end(),
        lowercaseInput.begin(), ::tolower);

    std::unordered_set<std::string> keywords = { "error", "critical", "warning",
                                                "alert", "suspicious"};
    std::unordered_set<std::string> fragments = { "err", "crit", "emerg",
                                                 "warn" };

    for (const auto& keyword : keywords) {
        size_t pos = lowercaseInput.find(keyword);
        while (pos != std::string::npos) {
            // 完整单词不匹配 _
            if (lowercaseInput.find(keyword) != std::string::npos) {
                return true;
            }
            pos = lowercaseInput.find(keyword, pos + 1);
        }
    }

    for (const auto& fragment : fragments) {
        size_t pos = lowercaseInput.find(fragment);
        while (pos != std::string::npos) {
            // 关键词前后只能出现_，或者关键词为开头或结尾
            if (((pos == 0 || lowercaseInput[pos - 1] == '_') &&
                (pos + fragment.length() == lowercaseInput.length() ||
                    lowercaseInput[pos + fragment.length()] == '_'))) {
                return true;
            }
            pos = lowercaseInput.find(fragment, pos + 1);
        }
    }

    return false;
}

bool FindErrorFuncsPass::doInitialization(llvm::Module* M) {
    std::string line;

    std::ifstream file_crix("./build/lib/configs/err-funcs");
    if (!file_crix.is_open())
    {
        std::ifstream file_crix2("./lib/configs/err-funcs");
        while (std::getline(file_crix2, line)) {
            crix_list.push_back(line);
        }
    }
    else {
        while (std::getline(file_crix, line)) {
            crix_list.push_back(line);
        }
    }


    std::ifstream file_free("./build/lib/configs/free-funcs");
    if (!file_free.is_open())
    {
        std::ifstream file_free2("./lib/configs/err-funcs");
        while (std::getline(file_free2, line)) {
            free_list.push_back(line);
        }
    }
    else {
        while (std::getline(file_free, line)) {
            free_list.push_back(line);
        }
    }

    return false;
}

bool FindErrorFuncsPass::doModulePass(llvm::Module* M) {

    for (Module::iterator f = M->begin(), fe = M->end(); f != fe; ++f) {
        Function* F = &*f;

        // Collect callers and callees
        for (inst_iterator i = inst_begin(F), e = inst_end(F); i != e; ++i) {
            if (CallInst* CI = dyn_cast<CallInst>(&*i)) {
                Function* Callee = CI->getCalledFunction();
                // errs() << *CI << "\n";

                // 识别错误处理代码段
                #if 0
                if (Callee && Callee->getName() == "llvm.dbg.label") {
                    // errs() << *CI << "\n";
                    if (CI->getNumOperands() >= 1) {
                        if (MetadataAsValue* md = dyn_cast<MetadataAsValue>(CI->getOperand(0))) {
                            if (DILabel* label = dyn_cast<DILabel>(md->getMetadata())) {
                                string name = label->getName().str();
                                if (is_error_func(name)) {
                                    string path = label->getFile()->getFilename().str();
                                    errs() << "[ Third-class code snippet\n  label: " << name
                                        << "\n  path:  " << label->getLine() << " @ " << path;

                                    // 分析label内部的内容
                                    int return_num = 0, error_handle_num = 0;
                                    BasicBlock *BB = CI->getParent();
                                    for (BasicBlock::iterator i = BB->begin(), e = BB->end(); i != e; ++i) {
                                        if (CallInst* Call = dyn_cast<CallInst>(i)) {
                                            string func_name = "";
                                            auto* called_Func = Call->getCalledFunction();
                                            if (called_Func != NULL) {
                                                func_name = called_Func->getName().str();
                                                for (const std::string& str : crix_list) {
                                                    if (func_name == str) {
                                                        error_handle_num ++;
                                                        break;
                                                    }
                                                }
                                            }
                                        }
                                        else if (ReturnInst* Call = dyn_cast<ReturnInst>(i)) {
                                            return_num ++;
                                        }
                                    }

                                    // 分析调用点的内容
                                    int check_num = 0, if_external = 0;
                                    UseSet use_set;
                                    for (auto predIterator = pred_begin(CI->getParent()); predIterator != pred_end(CI->getParent()); ++predIterator) {
                                        // 使用 predIterator 访问前驱基本块
                                        BasicBlock* predecessorBlock = *predIterator;
                                        if (predecessorBlock) {
                                            Instruction* Terminator = predecessorBlock->getTerminator();
                                            if (Terminator) {
                                                DebugLoc Loc = Terminator->getDebugLoc();
                                                if (Loc) {
                                                    use_set.insert(std::to_string(Loc->getLine()) + " @ " + Loc->getFilename().str() + "\n");
                                                    // 统计安全检查个数
                                                    BasicBlock* BB = CI->getParent();
                                                    if (BB) {
                                                        BasicBlock* PrevBB = BB->getPrevNode();
                                                        if (PrevBB) {
                                                            Instruction* terminate = PrevBB->getTerminator();
                                                            // errs() << *terminate << "\n";
                                                            if (terminate) {
                                                                if (BranchInst* bi = dyn_cast<BranchInst>(terminate)) {
                                                                    if (bi->isConditional()) {
                                                                        Value* op1 = terminate->getOperand(0);
                                                                        // errs() << *op1 << "\n";
                                                                        if (ICmpInst* cmp = dyn_cast<ICmpInst>(op1)) {
                                                                            check_num++;
                                                                            if (isa<ReturnInst>(cmp->getOperand(0)) || isa<Argument>(cmp->getOperand(0))
                                                                                || isa<ReturnInst>(cmp->getOperand(1)) || isa<Argument>(cmp->getOperand(1))) {
                                                                                if_external++;
                                                                            }
                                                                        }
                                                                        else if (isa<SwitchInst>(op1)) {
                                                                            check_num++;
                                                                        }
                                                                    }
                                                                }

                                                            }
                                                        }
                                                    }
                                                    // if(predIterator == pred_begin(CI->getParent()))
                                                    //     use_set.insert(std::to_string(Loc->getLine()) + " @ " + Loc->getFilename().str() + "\n");
                                                    //     // use += std::to_string(Loc->getLine()) + " @ " + Loc->getFilename().str() + "\n";
                                                    // else
                                                    //     use_set.insert("         " + std::to_string(Loc->getLine()) + " @ " + Loc->getFilename().str() + "\n");
                                                    //     // use += "         " + std::to_string(Loc->getLine()) + " @ " + Loc->getFilename().str() + "\n";
                                                }
                                            }
                                        }
                                    }

                                    if (use_set.size() == 0)
                                        use_set.insert("not found");
                                    errs() << "\n  use:   ";
                                    const auto& firstElement = *use_set.begin();

                                    for (const std::string& value : use_set) {
                                        if (value == firstElement)
                                            errs() << value;
                                        else
                                            errs() << "         " << value;
                                    }

                                    errs() << "\n  check num:   " << check_num << "\n";
                                    errs() << "\n  has external op:   " << if_external << "\n";
                                    errs() << "\n  return num:   " << return_num << "\n";
                                    errs() << "\n  error handle num:   " << error_handle_num << "\n";

                                    errs() << " ]\n";
                                }
                            }
                        }
                    }
                }
                #endif

                // else if(Callee && Callee->hasName()){

                // 识别错误处理函数
                #if 1
                if (Callee && Callee->hasName()) {
                    string name = Callee->getName().str();

                    if (is_error_func(name)) {
                        // BasicBlock& entryBlock = Callee->getEntryBlock();
                        // Function *body = entryBlock.getParent();
                        // if (name == "__ntfs_error") {
                            // errs() << name << "\n";
                        // }

                        // 消除IR中的版本号函数后缀，如“ProcReadStatusError.353”
                        size_t pos = name.find('.');
                        if (pos != std::string::npos) {
                            name = name.substr(0, pos);

                        }

                        std::string fileName;
                        unsigned int lineNumber;

                        if (DISubprogram* subprogram = Callee->getSubprogram()) {
                            // 获取源文件名字
                            fileName = subprogram->getFilename().str();

                            // 获取函数定义的行号
                            lineNumber = subprogram->getLine();

                            // 打印函数名字和源代码位置信息
                            // std::cout << "函数名字: " << name << std::endl;
                            // std::cout << "源文件: " << fileName << std::endl;
                            // std::cout << "行号: " << lineNumber << std::endl;
                            // std::cout << std::endl;
                        }

                        DebugLoc Loc = CI->getDebugLoc();
                        std::stringstream ss;
                        ss << (void *)Loc;
                        FuncUseMap::iterator it = func_use_map.find(name);
                        if (it != func_use_map.end()) {
                            FunctionInfo info = func_use_map[name];
                            info.use.insert(std::to_string(Loc->getLine()) +
                                " @ " + Loc->getFilename().str() + " " + ss.str());

                            // if (check_sum(info) < 3) {
                                judge_function_caller(CI, info);
                            // }

                            func_use_map.erase(name);
                            func_use_map.insert(std::make_pair(name, info));
                        }
                        else {
                            FunctionInfo info;
                            info.use.insert(std::to_string(Loc->getLine()) +
                                " @ " + Loc->getFilename().str() + " " + ss.str());
                            info.define.insert(std::to_string(lineNumber) +
                                " @ " + fileName);

                            FuncSet fs = Ctx->Callees[CI];
                            for (auto F : fs) {
                                if (F != NULL) {
                                    if (DISubprogram* subprogram = F->getSubprogram()) {
                                        fileName = subprogram->getFilename().str();
                                        lineNumber = subprogram->getLine();
                                        info.define.insert(
                                            std::to_string(lineNumber) + " @ " + fileName);
                                    }
                                    info.err_info = judge_function_body(F, 0);
                                }
                                // errs() << *F << "\n";
                            }
                            for (const std::string& str : crix_list) {
                                if (name == str) {
                                    info.err_info.self_if_in_crix++;
                                    break;
                                }
                            }

                            // if (check_sum(info) < 3) {
                                judge_function_caller(CI, info);
                            // }

                            func_use_map.insert(std::make_pair(name, info));
                        }
                    }
                }
                #endif
            }
        }
    }
    return false;
}

bool FindErrorFuncsPass::doFinalization(llvm::Module * M) { return false; }

void FindErrorFuncsPass::dump_func_use_map() {
    for (const auto& pair : func_use_map) {
        const std::string& key = pair.first;
        const FunctionInfo& values = pair.second;

        errs() << "[ All-class function\n  name: " << key << "\n  use : ";

        const auto& firstElement = *values.use.begin();

        for (const std::string& value : values.use) {
            if (value == firstElement)
                errs() << value << "\n";
            else
                errs() << "        " << value << "\n";
        }

        errs() << "  define : ";

        const auto& secondeElement = *values.define.begin();

        for (const std::string& value : values.define) {
            if (value == secondeElement)
                errs() << value << "\n";
            else
                errs() << "           " << value << "\n";
        }

        errs() << "  err info : ";

        ErrorJudge fb = values.err_info;

        errs() << "score: " + std::to_string(check_sum(values)) << "\n";
        errs() << "             err_print_num: " + std::to_string(fb.err_print_num) +
            "\n             free_num: " + std::to_string(fb.free_num) +
            "\n             unlock_num: " + std::to_string(fb.unlock_num) +
            "\n             err_handle_num: " + std::to_string(fb.err_handle_num) +
            "\n             self_if_in_crix: " + std::to_string(fb.self_if_in_crix) +
            "\n             exit_num: " + std::to_string(fb.exit_num) +
            "\n             err_return_num: " + std::to_string(fb.err_return_num) +
            "\n             if_caller_in_security_check: " + std::to_string(fb.if_caller_in_security_check / (float)(values.use.size())) +
            "\n"
            "\n             interrupted_dataflow_num: " + std::to_string(fb.interrupted_dataflow_num) +
            "\n             total lines: " + std::to_string(fb.total_lines) +
            "\n";

        errs() << " ]\n";
    }
}

struct MacroDefinition {
    std::string definition;
    std::string filePath;
    int lineNumber;
};

ErrorJudge FindErrorFuncsPass::judge_function_body(Function * F, int depth) {
    string name = F->getName().str();
    // errs() << name << "\n";
    // errs() << *F << "\n";

    ErrorJudge res;

    inst_iterator i = inst_begin(*F), e = inst_end(*F);
    e = --e;
    Instruction* instr2 = &(*(e));
    DebugLoc Loc2 = instr2->getDebugLoc();

    DISubprogram* sub_fun = F->getSubprogram();
    if (sub_fun && Loc2) {
        unsigned startLine = sub_fun->getLine();
        unsigned endLine = Loc2->getLine();
        res.total_lines = endLine - startLine - 1;
    }

    for (inst_iterator i = inst_begin(*F), e = inst_end(*F); i != e; ++i) {
        Instruction* instr = &(*i);
        // errs() << *instr << "\n";
        if (CallInst* Call = dyn_cast<CallInst>(instr)) {
            string func_name = "";
            auto* called_Func = Call->getCalledFunction();
            if (called_Func != NULL) {
                func_name = called_Func->getName().str();
            }

            // 过滤肯定不是错误处理函数的调用
            if (func_name == "llvm.dbg.value" ||
                func_name == "llvm.dbg.declare" || func_name == "llvm.dbg.label" ||
                func_name == "llvm.lifetime.start.p0i8" ||
                func_name == "llvm.lifetime.end.p0i8"||
                func_name == "") {
                continue;
            }

            DebugLoc Loc = Call->getDebugLoc();
            string source_code = "";
            if (Loc) {
                string path = Loc->getFilename().str();
                int line = Loc->getLine();
                // errs() << func_name << " " << line << " @ " << path << "\n";
                if (path.size() >= 23) {
                    source_code = read_line("/home/varas/Documents/data/aosp4.19/" + path.substr(23), line);
                }
            }
            string source_func_name = "";
            if (source_code != "" &&
                source_code.find("Read Error") == string::npos) {
                source_code = remove_extra_backslash(source_code);
                if (source_code.find("=") != string::npos) {
                    source_func_name =
                        source_code.substr(source_code.find_first_of("=") + 1,
                            source_code.find_first_of("("));
                }
                else if (source_code.find("(") != string::npos) {
                    source_func_name =
                        source_code.substr(0, source_code.find_first_of("("));
                }
            }
            // errs() << source_func_name << "\n";

            // 函数体内错误处理函数
            int temp = res.err_handle_num;
            for (const std::string& str : crix_list) {
                if (func_name == str) {
                    res.err_handle_num++;
                    break;
                }
                else {
                    if (source_func_name != "" && source_func_name == str) {
                        res.err_handle_num++;
                        break;
                    }
                }
            }

            // 函数体内的函数，向内部callee分析一层
            if (res.err_handle_num == temp && depth <= 1 &&
                is_error_func(func_name)) {
                FuncSet fs = Ctx->Callees[Call];
                for (auto F2 : fs) {
                    if (F2 != NULL) {
                        ErrorJudge ej = judge_function_body(F2, depth + 1);
                        FunctionInfo fb;
                        fb.err_info = ej;
                        if (check_sum(fb) >= 1) {
                            res.err_handle_num++;
                        }
                    }
                }
            }

            // 错误信息打印
            if (func_name == "fprintf" || func_name == "vfprintf") {
                if (LoadInst* li = dyn_cast<LoadInst>(Call->getOperand(0))) {
                    Value* v = li->getOperand(0);
                    if (v->hasName()) {
                        if (v->getName() == "stderr") {
                            res.err_print_num++;
                        }
                    }
                }
            }
            else if (func_name == "printk" || func_name == "printf" || func_name == "sprintf" || func_name == "sprintf") {
                int op = 0;
                if ( func_name == "sprintf") {
                    op = 1;
                }
                if (func_name == "snprintf") {
                    op = 2;
                }

                if (ConstantExpr* pCE = dyn_cast<ConstantExpr>(Call->getOperand(op)))
                {
                    Value* firstop = pCE->getOperand(0);
                    // BB = Instr->getParent();
                    if (GlobalVariable* GV = dyn_cast<GlobalVariable>(firstop))
                    {
                        if (GV->hasInitializer())
                        {
                            Constant* v = GV->getInitializer();
                            if (ConstantDataSequential* CA = dyn_cast<ConstantDataSequential>(v)) {
                                if (CA->isString()) {
                                    StringRef str = CA->getAsString();
                                    if (str.find("error") != string::npos || str.find("warning") != string::npos) {
                                        if (str.find("could not handle") == string::npos) {
                                            res.err_print_num++;
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }

            // 中止函数调用
            if (func_name == "panic" || func_name == "exit" || func_name == "abort" || func_name == "BUG" ||
                func_name == "BUG_ON" || func_name == "BUG_ON_ONCE") {
                res.exit_num++;
            }

            // free操作
            for (const std::string& str : free_list) {
                if (func_name == str) {
                    res.free_num++;
                    break;
                }
                else {
                    if (source_func_name != "" && source_func_name == str) {
                        res.free_num++;
                        break;
                    }
                }
            }

            // unlock操作
            if (func_name.find("unlock") != string::npos) {
                res.unlock_num++;
            }
            else {
                if (source_func_name != "" &&
                    source_func_name.find("unlock") != string::npos) {
                    res.unlock_num++;
                    break;
                }
            }
        }
    }

    // errs() << res.err_print_num << " " << res.free_num << " "
    //     << res.unlock_num<< " " << res.err_handle_num << " " <<
    //     res.err_return_num << "\n";
    return res;
}

void FindErrorFuncsPass::judge_function_caller(CallInst * CI, FunctionInfo & info) {
    // 判断caller有无安全检查
    // todo：在同一个基本块中有无其他错误处理操作，如goto跳转
    BasicBlock* BB = CI->getParent();
    if (BB) {
        BasicBlock* PrevBB = BB->getPrevNode();
        if (PrevBB) {
            Instruction* terminate = PrevBB->getTerminator();
            // errs() << *terminate << "\n";
            if (terminate) {
                if (BranchInst* bi = dyn_cast<BranchInst>(terminate)) {
                    if (bi->isConditional()) {
                        Value* op1 = terminate->getOperand(0);
                        // errs() << *op1 << "\n";
                        if (isa<CmpInst>(op1) || isa<SwitchInst>(op1)) {
                            info.err_info.if_caller_in_security_check++;
                        }
                    }
                }
            }
        }

        // 判断返回值有无被条件判断使用
        // todo：目前只分析了一层
        if (Value* ret = dyn_cast<Value>(CI)) {
            Function* F = BB->getParent();
            if (F) {
                for (inst_iterator i = inst_begin(F), ei = inst_end(F); i != ei; ++i) {
                    Instruction* Inst = &*i;

                    if (CmpInst* ci = dyn_cast<CmpInst>(&*i)) {
                        unsigned NumOperands = ci->getNumOperands();
                        for (unsigned num = 0; num < NumOperands; ++num) {
                            Value* op = ci->getOperand(num);
                            Value* op_source = findOriginOfPointer(op);
                            Value* op_alias;
                            if (LoadInst* li = dyn_cast<LoadInst>(op)) {
                                Value* temp = li->getOperand(0);
                                if (temp) {
                                    BasicBlock::iterator it(li);  // 其中currentInstruction是LLVM中的指令
                                    if (it != li->getParent()->begin()) {
                                        Instruction* prevInstruction = &*(--it);
                                        if (StoreInst* si = dyn_cast<StoreInst>(prevInstruction)) {
                                            if (prevInstruction->getOperand(1) == temp) {
                                                op_alias = prevInstruction->getOperand(0);
                                            }
                                        }
                                    }
                                }
                            }
                            // todo：op指针的别名分析
                            if (op == ret || op_source == ret || op_alias == ret) {
                                info.err_info.err_return_num++;

                                inst_iterator i_next = ++i;
                                if (BranchInst* bi = dyn_cast<BranchInst>(&*i_next)) {
                                    Value* op1 = bi->getOperand(0);
                                    // errs() << *op1 << "\n";
                                    string name = op1->getName().str();
                                    // if (is_error_func(name)) {
                                        BasicBlock* SuccBB = BB->getTerminator()->getSuccessor(0);
                                        if (SuccBB) {
                                            Instruction* terminate = SuccBB->getTerminator();
                                            // errs() << *terminate2 << "\n";
                                            if (terminate) {
                                                if (ReturnInst* ri = dyn_cast<ReturnInst>(terminate)) {
                                                    info.err_info.interrupted_dataflow_num++;
                                                }
                                                else if (BranchInst* bi2 = dyn_cast<BranchInst>(terminate)) {
                                                    BasicBlock* SuccBB2 = bi2->getSuccessor(0);
                                                    if (SuccBB2) {
                                                        Instruction* terminate2 = SuccBB2->getTerminator();
                                                        if (terminate2) {
                                                            if (ReturnInst* ri = dyn_cast<ReturnInst>(terminate2)) {
                                                                info.err_info.interrupted_dataflow_num++;
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    // }
                                }
                            }
                        }
                    }
                }
            }
        }

        // 分析调用点是否存在中断数据流的操作
        Instruction* terminate = BB->getTerminator();
        // errs() << *BB << "\n";
        if (terminate) {
            if (BranchInst* bi = dyn_cast<BranchInst>(terminate)) {
                unsigned numSuccessors = bi->getNumSuccessors();
                if (numSuccessors > 1) {
                    Value* op1 = terminate->getOperand(0);
                    // errs() << *op1 << "\n";
                    string name = op1->getName().str();
                    // if (is_error_func(name)) {
                        BasicBlock* SuccBB = BB->getSingleSuccessor();
                        if (SuccBB) {
                            Instruction* terminate2 = SuccBB->getTerminator();
                            // errs() << *terminate2 << "\n";
                            if (terminate2) {
                                if (ReturnInst* ri = dyn_cast<ReturnInst>(terminate2)) {
                                    info.err_info.interrupted_dataflow_num++;
                                }
                            }
                        }
                    // }
                }
            }
            else if (ReturnInst* ri = dyn_cast<ReturnInst>(terminate)) {
                bool ifPlus = true;
                BasicBlock* BB = ri->getParent();
                if (BB) {
                    Function* F = BB->getParent();
                    if (F) {
                        if (F->size() == 1) {
                            ifPlus = false;
                        }
                        else {
                            inst_iterator i = inst_begin(*F), e = inst_end(*F);
                            e = --e;
                            Instruction* instr = &(*(e));
                            DebugLoc Loc = instr->getDebugLoc();

                            DISubprogram* sub_fun = F->getSubprogram();
                            if (sub_fun && Loc) {
                                unsigned startLine = sub_fun->getLine();
                                unsigned endLine = Loc->getLine();
                                if (endLine - startLine - 1 <= 1) {
                                    ifPlus = false;
                                }
                            }
                        }
                    }
                }
                if (ifPlus) {
                    info.err_info.interrupted_dataflow_num++;
                }
            }
        }
    }
}

void FindErrorFuncsPass::read_source_code(string path) {
    std::ifstream file_list(path);
    std::string file_path;
    while (std::getline(file_list, file_path)) {
        std::ifstream file(file_path);
        std::string line;
        std::vector<MacroDefinition> macroDefinitions;
        bool isMacroDefinition = false;
        std::string currentFilePath = file_path;
        int currentLineNumber = 0;

        while (std::getline(file, line)) {
            currentLineNumber++;

            if (isMacroDefinition) {
                // Check if the line is part of the macro definition
                if (line.empty() || line[0] == ' ' || line[0] == '\t') {
                    // Remove extra tabs and backslash from the line
                    line = remove_extra_backslash(line);

                    // Append the processed line to the macro definition
                    macroDefinitions.back().definition += line;
                }
                else {
                    // Macro definition complete
                    macroDefinitions.back().filePath = currentFilePath;

                    // Reset variables for the next macro definition
                    isMacroDefinition = false;
                }
            }

            // Check if the line starts with "#define"
            if (line.find("#define") == 0) {
                // Start of a new macro definition
                MacroDefinition newMacroDefinition;
                newMacroDefinition.definition = remove_extra_backslash(line);
                newMacroDefinition.filePath = currentFilePath;
                newMacroDefinition.lineNumber = currentLineNumber;
                macroDefinitions.push_back(newMacroDefinition);

                isMacroDefinition = true;
            }
        }

        file.close();

        // Print the collected macro definitions with file paths and line
        // numbers
        for (const auto& macro : macroDefinitions) {
            std::regex macroRegex("#define\\s+(\\w+)\\s*\\(([^)]*)\\)\\s*(.*)");
            std::smatch match;

            if (std::regex_search(macro.definition, match, macroRegex)) {
                std::string macroName = match[1].str();

                std::string macroArgs = match[2].str();
                std::string macroContent = match[3].str();

                // 提取宏定义后的函数名称
                std::regex functionNameRegex("\\b(\\w+)\\s*\\(");
                std::smatch functionNameMatch;
                std::string functionName;

                if (std::regex_search(macroContent, functionNameMatch,
                    functionNameRegex)) {
                    functionName = functionNameMatch[1].str();
                }

                if (!is_error_func(macroName) && !is_error_func(functionName))
                    continue;

                // 提取宏定义前的内容
                std::string preMacroContent =
                    macro.definition.substr(0, match.position());

                std::cout << "Macro Definition: " << macro.definition
                    << std::endl;
                std::cout << "Macro Name: " << macroName << std::endl;
                // std::cout << "Macro Args: " << macroArgs << std::endl;
                // std::cout << "Macro Content: " << macroContent << std::endl;
                if (functionName == "")
                    std::cout << "Pre-Macro Content: " << preMacroContent
                    << std::endl;
                else
                    std::cout << "Function Name: " << functionName << std::endl;
                std::cout << "File Path: " << macro.filePath << std::endl;
                std::cout << "Line Number: " << macro.lineNumber << std::endl;
                std::cout << "------------------------------------------"
                    << std::endl;
            }
        }
    }
}

std::string FindErrorFuncsPass::remove_extra_backslash(std::string line) {
    // Remove leading tabs and spaces
    line.erase(0, line.find_first_not_of(" \t"));

    // Remove trailing tabs and spaces
    line.erase(line.find_last_not_of(" \t") + 1);

    // Remove multiple consecutive tabs and spaces
    size_t pos;
    while ((pos = line.find("\t\t")) != std::string::npos) {
        line.replace(pos, 2, "\t");
    }

    // Remove trailing backslash
    if (line.back() == '\\') {
        line.pop_back();
    }

    return line;
}

float FindErrorFuncsPass::check_sum(FunctionInfo fb) {
    // 权重可以调整
    float res = 0;
    res += fb.err_info.err_handle_num * 10;
    res += fb.err_info.err_print_num;
    res += fb.err_info.err_return_num;
    res += fb.err_info.free_num;
    res += fb.err_info.unlock_num * 0.4;
    res += fb.err_info.exit_num * 10;
    res += fb.err_info.self_if_in_crix * 10;

    if (fb.use.size() != 0) {
        res += fb.err_info.if_caller_in_security_check / (float)(fb.use.size());
    }

    return res;
}

string FindErrorFuncsPass::read_line(string filename, int line) {
    int lines, i = 0;
    string temp;
    fstream file;
    file.open(filename.c_str());

    if (line <= 0) {
        return "Read Error 1: 行数错误, 不能为0或负数。";
    }
    if (file.fail()) {
        return "Read Error 2: 文件不存在。";
    }
    while (getline(file, temp) && i < line - 1) {
        i++;
    }
    file.close();
    return temp;
}

Value *FindErrorFuncsPass::findOriginOfPointer(Value *pointer)
{
	std::set<Value *> originSet;
	std::set<Value *> valuesExploredSet;
	std::queue<Value *> valuesToExplore;

	valuesToExplore.push(pointer);

	while (!valuesToExplore.empty())
	{
		Value *currentValue = valuesToExplore.front();
		//dbgs()<<"currentValue:"<<*currentValue<<"\n";
		valuesToExplore.pop();

		//if this value has been explored already, then don't explore it
		if (valuesExploredSet.count(currentValue) > 0)
		{
			continue;
		}

		valuesExploredSet.insert(currentValue);

		if (CastInst *CAST = dyn_cast<CastInst>(currentValue))
		{
			//get the operand being cast, this will get us to memory location
			valuesToExplore.push(CAST->getOperand(0));
		}
		else if (LoadInst *LoadI = dyn_cast<LoadInst>(currentValue))
		{
			//get the operand being cast, this will get us to memory location
			valuesToExplore.push(LoadI->getOperand(0));
		}
		else if (PHINode *PHI = dyn_cast<PHINode>(currentValue))
		{
			unsigned int i;
			for (i = 0; i < PHI->getNumIncomingValues(); i++)
			{
				valuesToExplore.push(PHI->getIncomingValue(i));
			}
		}
		else if (GetElementPtrInst *GEP = dyn_cast<GetElementPtrInst>(currentValue))
		{
			valuesToExplore.push(GEP->getPointerOperand());
		}
		else
		{
			//since we have a value and we don't know what to do with it, we should
			////add it origin set, if it is the only value in the origin set then this will
			////be the origin value.
			originSet.insert(currentValue);
		}
	}

	if (originSet.size() == 1)
	{
		return *(originSet.begin());
	}
	else
	{
		return NULL;
	}
}