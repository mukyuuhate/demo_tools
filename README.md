**部署**

**1.1. 部署形态**

错误处理函数识别原型工具（简称工具）基于LLVM 15.0.7开发（代码已适配LLVM 10.0.0），主要代码逻辑位于demo_tools目录下。工具采用源码编译形态部署，并附带用于测试的AOSP bitcode文件。编译命令如下：

cd /你的路径/demo_tools/analyzer;make

需要预装的依赖包括：cmake，LLVM 15.0.7 / LLVM 10.0.0

建议的硬件配置：16核 64GB Intel Xeon Cascade Lake 8255C/Intel Xeon Cooper Lake(2.5GHz/3.1GHz)

**1.2. 环境配置**

1. 使用apt安装的环境依赖
- 基础环境：sudo apt install build-essential
- cmake：sudo apt-get install cmake
- LLVM 15.0.7：sudo apt-get install clang-15，sudo apt-get install llvm-15

or

LLVM 10.0.0：sudo apt-get install clang-10，sudo apt-get install llvm-10

1. 设置环境变量
- 设置llvm：export LLVM_DIR=/usr/lib/llvm-15/lib/cmake/llvm

**1.3. 目录结构**

工具的目录结如表 1所示。

表 1 目录结构说明

| 目录 |  | 内容 |
| --- | --- | --- |
| analyzer | src | 包含了cmake编译文件、工具源代码和配置文件 |
|  | build | 存放工具的编译结果，如可执行文件等 |
| tools |  | 存放一些工具shell，如生成输入文件列表、处理工具结果等 |
| test | AOSP_4.19_bc | AOSP 4.19版本的bitcode文件，编译选项中主要包含-g、-fno-discard-value-names、-O0和-fno-inline |
1. **使用说明**

**2.1.  使用步骤**

工具的使用步骤如下：

1. **输入准备：**输入为bitcode文件，支持单文件输入和多文件批量输入，编译得到bitcode列表需要-g、-fno-discard-value-names、-O0和-fno-inline选项。多文件批量输入需要准备bitcode文件列表，可以使用tools目录下的“sh “文件生成，使用方法为`bash /你的路径/getBitcodePath.sh /bitcode文件夹绝对路径/ 文件列表名称`；
2. **执行检测：**生成的可执行文件在“/你的路径/demo_tools/analyzer/build/lib/kanalyzer“路径下，使用方法为进入”/你的路径/ demo_tools/analyzer/build “，然后执行”./lib/kanalyzer bitcode文件路径“或”./build/lib/kanalyzer @文件列表路径“，

可以使用nohup指令后台运行并将结果保存至文件中，

如：“nohup ./lib/kanalyzer @文件列表路径 > 结果文件名称 & “；

1. **结果查看：**检测结果保存在“demo_tools/analyzer/build”目录下。

**2.2.  结果格式**

错误处理函数的识别结果如下图所示，包含函数名称name，函数使用点use和函数定义点define三项内容，其中use和define的形式为“行号@相对路径“。用户还可以使用tools工具中的“judge_if_in_crix.cc“提取函数名和定义点，并保存到”\t“分隔的列表中。

图 1：工具结果示例

（完）
