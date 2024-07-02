import re
import os
import pandas as pd

# 读取文本文件
with open('/home/varas/Documents/project/demo_tool/analyzer/build/aosp_err_5.log', 'r') as file:
    content = file.read()

# 使用正则表达式提取数据
pattern = r"name: (.*?)\n.*?define :([\s\S]+?)err info : score: (\d+\.?\d+)"
matches = re.findall(pattern, content, re.S)

# 处理define的内容
data = []
for match in matches:
    name, define, score = match
    paths = re.findall(r"\d+ @ (.*?\.c)\n", define)
    folder_name = ''
    if len(paths) > 0:
        # print(paths[0] + " ")
        folder_name = os.path.dirname(paths[0]).split('/')[2]
        # print("     " + folder_name)
    data.append((name, folder_name, paths, score))

# 将提取的数据存储到DataFrame中
df = pd.DataFrame(data, columns=['Name','Module', 'Paths', 'Score'])

excel_data = pd.read_excel(io='/home/varas/Documents/project/demo_tool/tools/人工审计结果.xlsx')
merged_data = pd.merge(excel_data, df, on='Name', how='right')

# 创建新的DataFrame只包含name和score列
result_df = merged_data[['Name','Module', 'Paths', 'Score', '分类']].copy()
result_df.to_excel('output_3.xlsx', index=False)

# 打印结果DataFrame
print(result_df)

