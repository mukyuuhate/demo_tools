#include <iostream>
#include <fstream>
#include <string>
#include <vector>

int main() {
    std::string line;

    std::ifstream file_crix("/home/mukyuuhate/Documents/git/crix/crix/analyzer/src/lib/configs/err-funcs");
    std::vector<std::string> crix_list;
    while (std::getline(file_crix, line)) {
        crix_list.push_back(line);
    }

    std::ifstream file_first("/home/mukyuuhate/Documents/git/ndi-main/analyzer/build/all_first_err.log");
    // std::vector<std::string> function_list;
    std::vector<std::pair<std::string, std::string>> function_list;
    while (std::getline(file_first, line)) {
        if(line.find("name:") != std::string::npos){
            std::string first = line.substr(8);
            std::string second = "";
            while (std::getline(file_first, line)) {
                if(line.find("First-class") != std::string::npos){
                    if(second == "")
                        second = "not found";
                    break;
                }
                else if(line.find("define:") != std::string::npos){
                    second = line.substr(16);
                    break;
                }
            }
            function_list.push_back(make_pair(first, second));
        }

    }

    std::vector<std::string> res_in;
    std::vector<std::string> res_out;
    std::vector<std::string> res_out_path;
    for (auto pair : function_list) {
        const std::string &str1 = pair.first;
        bool found = false;
        for (const std::string& str2 : crix_list) {
            if (str1 == str2) {
                found = true;
                res_in.push_back(str1);
                break;
            }
        }
        if (!found) {
            res_out.push_back(str1);
            res_out_path.push_back(pair.second);
        }
    }

    // for(const std::string& a: crix_list) {
    //     if(std::find(function_list.begin(), function_list.end(), a) != function_list.end()) {
    //         res_in.push_back(a);
    //     } else {
    //         res_out.push_back(a);
    //     }
    // }

    std::ofstream file_in("output_in_name.txt");

    if (file_in.is_open()) {
        for (std::string str : res_in) {
            file_in << str << std::endl;
        }

        file_in.close();
        std::cout << "Strings have been written to the file." << std::endl;
    }

    std::ofstream file_out("output_out_name.txt");

    if (file_out.is_open()) {
        for (std::string str : res_out) {
            file_out << str << std::endl;
        }

        file_out.close();
        std::cout << "Strings have been written to the file." << std::endl;
    }

    std::ofstream file_out_path("output_out_path.txt");

    if (file_out_path.is_open()) {
        for (std::string str : res_out_path) {
            file_out_path << str << std::endl;
        }

        file_out_path.close();
        std::cout << "Strings have been written to the file." << std::endl;
    }

    return 0;
}