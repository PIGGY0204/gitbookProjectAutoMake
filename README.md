# GitBook Project Auto Make Script

## 使用方法

`./gitbookProjectAutoMake.sh [project_path] [config_file_path]`

**project_path:** 要创建项目的路径

**config_file_path:** 配置文件的路径

只输入一个参数时， config 文件默认为传入项目路径下的 config 文件

两个都不输入的时候默认在脚本的目录下创建，配置文件是和脚本同目录的名为 config 的文件

## config 文件

使用此脚本创建 GitBook 项目需要写一个 config 配置文件告诉脚本要创建的内容

config 文件格式：`[grade] [title] [fileName]`

**grade:** 标题的等级，只能有两级。一级：# 二级：##

**title:** 标题

**fileName:** 文件名。该文章对应的文件名，不需要写后缀，如果一级标题的 fileName 为 README 则将在根目录创建 README.md

例子：

```
# title fileName
  ## title fileName
  ## title fileName
# title fileName
  ## title fileName
```
