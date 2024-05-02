#!/bin/bash

# 输出 JSON 数组的开头
echo "[" > directory_info.json
# 遍历根目录
find ./ -name "*.md" -exec ls -l --time-style=+"%Y-%m-%d %H:%M:%S" {} + | sort -r -k 6,7 | awk '{print "{\"filepath\":\""$8"\",\"size\":\""$5"\",\"last_modified\":\""$6" "$7"\"},"}' | sed '$ s/,$//' >> directory_info.json
# 输出 JSON 数组的结尾
echo "]" >> directory_info.json