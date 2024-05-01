#!/bin/bash

function traverse_directory() {
  local directory="${1}"
  local indent="${2}"
  local first_entry="true"
  local files=()

  # 遍历目录中的文件和子目录
  for file in "${directory}"/*; do
    # 判断是否是目录
    if [ -d "${file}" ]; then
      # 递归遍历子目录
      traverse_directory "${file}" "${indent}    "
    elif [ -f "${file}" ] && [[ "${file}" == *.md ]]; then
      # 提取文件名、最后修改日期和字数
      local filename="${file##*/}"
      local modified_date=$(date -r "${file}" +%Y-%m-%d\ %H:%M:%S)
      # 添加到文件数组
      files+=("{ \"relative_path\": \"${directory}\", \"filename\": \"${filename}\", \"modified_date\": \"${modified_date}\" }")
    fi
  done

  # 输出文件数组中的项
  for ((i = 0; i < ${#files[@]}; i++)); do
    if [ "${first_entry}" = "true" ]; then
      first_entry="false"
    else
      echo ","
    fi
    echo "${indent}  ${files[i]}"
  done
}

# 根目录路径
root_directory="."

# 输出 JSON 数组的开头
echo "[" > directory_info.json
# 遍历根目录
traverse_directory "${root_directory}" "  " | paste -sd "," >> directory_info.json
# 输出 JSON 数组的结尾
echo "]" >> directory_info.json