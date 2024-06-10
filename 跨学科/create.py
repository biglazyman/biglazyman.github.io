import os

def create_nested_folders(text_file, root_folder):
    with open(text_file, 'r',encoding='utf-8') as file:
        lines = file.readlines()

    stack = []
    for line in lines:
        level = line.count('\t')
        folder_name = line.strip()

        while len(stack) > level:
            stack.pop()

        parent_path = os.path.join(root_folder, *stack)
        folder_path = os.path.join(parent_path, folder_name)

        os.makedirs(folder_path, exist_ok=True)
        stack.append(folder_name)

    print("文件夹创建完成。")

# 示例用法
text_file = 'category.txt'  # 替换为你的文本文件路径
root_folder = './'  # 替换为你希望创建文件夹的根目录

create_nested_folders(text_file, root_folder)