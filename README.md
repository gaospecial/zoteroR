
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Zotero in R

<!-- badges: start -->

[![R-CMD-check](https://github.com/gaospecial/zoteroR/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/gaospecial/zoteroR/actions/workflows/R-CMD-check.yaml)
[![pkgdown](https://github.com/gaospecial/zoteroR/actions/workflows/pkgdown.yaml/badge.svg)](https://github.com/gaospecial/zoteroR/actions/workflows/pkgdown.yaml)
[![Codecov test
coverage](https://codecov.io/gh/gaospecial/zoteroR/branch/main/graph/badge.svg)](https://app.codecov.io/gh/gaospecial/zoteroR?branch=main)
[![CRAN
status](https://www.r-pkg.org/badges/version/zoteroR)](https://CRAN.R-project.org/package=zoteroR)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![](https://img.shields.io/github/languages/code-size/gaospecial/zoteroR.svg)](https://github.com/gaospecial/zoteroR)
[![](https://img.shields.io/github/last-commit/gaospecial/zoteroR.svg)](https://github.com/gaospecial/zoteroR/commits/main)
<!-- badges: end -->

The goal of `zoteroR` is to provide a convenient interface to the Zotero
API in R.

## Installation

You can install the development version of zoteroR from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("gaospecial/zoteroR")
```

## Example

This is a basic example which shows you how to solve a common problem:

### 初始化客户端

``` r
library(zoteroR)
## basic example code
client <- zotero_client(
  library_id = Sys.getenv("ZOTERO_USER_ID"),
  library_type = "user",
  api_key = Sys.getenv("ZOTERO_API_KEY")
)
```

### 获取项目

``` r
# Get 10 items
items <- get_items(client, limit = 10)
dim(items)
#> [1] 10  6
colnames(items)
#> [1] "key"     "version" "library" "links"   "meta"    "data"
```

### 获取项目数量

``` r
# Get total number of top-level items in the library
num_top_items(client)
#> [1] 2136

# Get total number of items in a collection
num_all_items(client)
#> [1] 4251
```

### 搜索

``` r
# 获取所有保存的搜索
searches <- get_searches(client)

search_key = searches$key[1]

# 获取特定的搜索
search <- get_search(client, search_key)
str(search)
#> List of 5
#>  $ key    : chr "ZS5NHLXC"
#>  $ version: int 21528
#>  $ library:List of 4
#>   ..$ type : chr "user"
#>   ..$ id   : int 62236
#>   ..$ name : chr "gaoch"
#>   ..$ links:List of 1
#>   .. ..$ alternate:List of 2
#>   .. .. ..$ href: chr "https://www.zotero.org/springgao"
#>   .. .. ..$ type: chr "text/html"
#>  $ links  :List of 1
#>   ..$ self:List of 2
#>   .. ..$ href: chr "https://api.zotero.org/users/62236/searches/ZS5NHLXC"
#>   .. ..$ type: chr "application/json"
#>  $ data   :List of 4
#>   ..$ key       : chr "ZS5NHLXC"
#>   ..$ version   : int 21528
#>   ..$ name      : chr "Microsoft Word.app"
#>   ..$ conditions:'data.frame':   1 obs. of  3 variables:
#>   .. ..$ condition: chr "title"
#>   .. ..$ operator : chr "contains"
#>   .. ..$ value    : chr ""
```

下面的操作需要API key有写权限。

``` r
# 创建新的搜索
new_search <- create_search(client, 
                          name = "Recent ML Papers",
                          conditions = list(
                            list(
                              condition = "title",
                              operator = "contains",
                              value = "machine learning"
                            ),
                            list(
                              condition = "date",
                              operator = "isInTheLast",
                              value = "1 month"
                            )
                          ))

# 删除搜索
delete_search(client, search_key)
```

### 标签操作

获取标签：

``` r
# 获取所有标签
tags <- get_tags(client)

# 获取特定标签
specific_tag <- get_tag(client, "VIP")

# 获取顶层条目的标签
top_tags <- get_items_top_tags(client)

# 获取回收站中的标签
trash_tags <- get_items_trash_tags(client)
```

获取特定条目或集合的标签：

``` r
# 假设我们有一个条目的key
item_key <- items$key[1]

# 获取该条目的标签
item_tags <- get_item_tags(client, item_key)

# 获取特定集合的标签
collections <- get_collections(client)
if (length(collections) > 0) {
  collection_key <- collections[[1]]$key
  collection_tags <- get_collection_tags(client, collection_key)
  
  # 获取集合中条目的标签
  collection_items_tags <- get_collection_items_tags(client, collection_key)
  
  # 获取集合中顶层条目的标签
  collection_top_tags <- get_collection_items_top_tags(client, collection_key)
}
```

获取特殊位置的标签：

``` r
# 获取"我的出版物"中的标签
publication_tags <- get_publications_tags(client)
```

### 集合操作

``` r
# 获取所有集合
collections <- get_collections(client)

# 获取顶层集合
top_collections <- get_collections_top(client)

if (length(collections) > 0) {
  # 获取特定集合
  collection <- get_collection(client, collections[[1]]$key)
  
  # 获取子集合
  subcollections <- get_subcollections(client, collections[[1]]$key)
}
```

创建和删除集合（需要写权限）：

``` r
# 创建新集合
new_collection <- create_collection(client, name = "My New Collection")

# 创建子集合
if (length(collections) > 0) {
  sub_collection <- create_collection(
    client,
    name = "Sub Collection",
    parent_key = collections[[1]]$key
  )
  
  # 删除集合
  delete_collection(client, sub_collection$key)
}
```

### 文件和附件操作

获取和下载文件：

``` r
# 首先获取条目及其附件
items <- get_items(client)
item_key <- items[[8]]$key

# 获取该条目的子项目（附件）
attachments <- children(client, item_key)

# 如果有附件，获取第一个附件的内容
if (length(attachments) > 0) {
  attachment_key <- attachments[[1]]$key
  
  # 获取文件内容
  file_content <- get_file(client, attachment_key)
  
  # 下载文件到本地
  # 自动使用原始文件名
  file_path <- download_file(client, attachment_key)
  
  # 指定保存路径和文件名
  file_path <- download_file(client, attachment_key, 
                            filename = "my_paper.pdf",
                            path = "downloads")
}
```

上传附件（需要写权限）：

``` r
# 创建单个文件附件
result <- create_attachment(client, 
                          files = "path/to/document.pdf")

# 创建多个文件附件
result <- create_attachment(client, 
                          files = c("doc1.pdf", "doc2.pdf"))

# 创建子附件（关联到父条目）
parent_key <- items[[1]]$key
result <- create_attachment(client,
                          files = "supplementary.pdf",
                          parent_key = parent_key)

# 使用不同的链接模式
# 可选的模式：imported_file, imported_url, linked_file, linked_url
result <- create_attachment(client,
                          files = "local_file.pdf",
                          link_mode = "linked_file")
```

注意事项：

1.  文件下载功能会自动从响应头中获取原始文件名
2.  可以指定保存路径，如果路径不存在会自动创建
3.  上传附件支持单个或多个文件
4.  可以创建独立附件或关联到现有条目
5.  支持不同的链接模式（导入文件、导入URL、链接文件、链接URL）

### 版本控制

获取版本信息：

``` r
# 获取最后修改的版本号
last_version <- get_last_modified_version(client)

# 获取所有条目的版本信息
item_versions <- get_item_versions(client)

# 获取特定版本之后的修改
recent_versions <- get_item_versions(client, since = last_version - 100)

# 获取集合的版本信息
collection_versions <- get_collection_versions(client)
```

获取删除的内容：

``` r
# 获取从特定版本之后删除的内容
if (last_version > 0) {
  deleted <- get_deleted(client, since = last_version - 100)
}
```

更新带版本控制的条目（需要写权限）：

``` r
# 更新单个条目
item <- item(client, item_key)
new_data <- list(
  title = "Updated Title",
  date = "2024"
)
result <- update_item_version(client, 
                            item_key = item$key,
                            data = new_data,
                            version = item$version)

# 批量更新条目
items_to_update <- list(
  list(
    key = "KEY1",
    data = list(title = "New Title 1")
  ),
  list(
    key = "KEY2",
    data = list(title = "New Title 2")
  )
)
result <- update_items_version(client, 
                             items = items_to_update,
                             version = last_version)
```

注意事项：

1.  版本号是单调递增的整数
2.  使用版本控制可以避免并发更新冲突
3.  更新时必须提供正确的版本号
4.  获取删除的内容时必须提供 since 参数

### 群组和特殊集合

获取群组和出版物：

``` r
# 获取用户可访问的群组
groups <- get_groups(client)

# 获取"我的出版物"中的条目
publications <- get_publications(client)
```

### 批量操作

获取特定条目：

``` r
# 获取前10个条目的key
items <- get_items(client, limit = 10)
keys <- sapply(items, function(x) x$key)

# 获取特定条目子集
subset <- get_item_subset(client, keys[1:3])
```

获取所有内容：

``` r
# 获取所有条目（自动处理分页）
all_items <- get_all_items(client)

# 获取所有集合（包括子集合）
all_collections <- get_all_collections(client)

# 获取特定集合下的所有子集合
if (length(collections) > 0) {
  collection_key <- collections[[1]]$key
  sub_collections <- get_all_collections(client, collection_key)
}
```
