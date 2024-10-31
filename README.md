
<!-- README.md is generated from README.Rmd. Please edit that file -->

# zoteroR

<!-- badges: start -->
<!-- badges: end -->

The goal of zoteroR is to provide a convenient interface to the Zotero
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
```

### 获取项目数量

``` r
# Get total number of top-level items in the library
num_top_items(client)
#> [[1]]
#> [[1]]$key
#> [1] "Z5NE7NV2"
#> 
#> [[1]]$version
#> [1] 21936
#> 
#> [[1]]$library
#> [[1]]$library$type
#> [1] "user"
#> 
#> [[1]]$library$id
#> [1] 62236
#> 
#> [[1]]$library$name
#> [1] "gaoch"
#> 
#> [[1]]$library$links
#> [[1]]$library$links$alternate
#> [[1]]$library$links$alternate$href
#> [1] "https://www.zotero.org/springgao"
#> 
#> [[1]]$library$links$alternate$type
#> [1] "text/html"
#> 
#> 
#> 
#> 
#> [[1]]$links
#> [[1]]$links$self
#> [[1]]$links$self$href
#> [1] "https://api.zotero.org/users/62236/items/Z5NE7NV2"
#> 
#> [[1]]$links$self$type
#> [1] "application/json"
#> 
#> 
#> [[1]]$links$alternate
#> [[1]]$links$alternate$href
#> [1] "https://www.zotero.org/springgao/items/Z5NE7NV2"
#> 
#> [[1]]$links$alternate$type
#> [1] "text/html"
#> 
#> 
#> 
#> [[1]]$meta
#> [[1]]$meta$creatorSummary
#> [1] "Raglin et al."
#> 
#> [[1]]$meta$parsedDate
#> [1] "2024-09-05"
#> 
#> [[1]]$meta$numChildren
#> [1] 2
#> 
#> 
#> [[1]]$data
#> [[1]]$data$key
#> [1] "Z5NE7NV2"
#> 
#> [[1]]$data$version
#> [1] 21936
#> 
#> [[1]]$data$itemType
#> [1] "journalArticle"
#> 
#> [[1]]$data$title
#> [1] "Manipulating the Maize (Zea mays) Microbiome"
#> 
#> [[1]]$data$creators
#> [[1]]$data$creators[[1]]
#> [[1]]$data$creators[[1]]$creatorType
#> [1] "author"
#> 
#> [[1]]$data$creators[[1]]$firstName
#> [1] "Sierra S."
#> 
#> [[1]]$data$creators[[1]]$lastName
#> [1] "Raglin"
#> 
#> 
#> [[1]]$data$creators[[2]]
#> [[1]]$data$creators[[2]]$creatorType
#> [1] "author"
#> 
#> [[1]]$data$creators[[2]]$firstName
#> [1] "Alonso"
#> 
#> [[1]]$data$creators[[2]]$lastName
#> [1] "Favela"
#> 
#> 
#> [[1]]$data$creators[[3]]
#> [[1]]$data$creators[[3]]$creatorType
#> [1] "author"
#> 
#> [[1]]$data$creators[[3]]$firstName
#> [1] "Daniel"
#> 
#> [[1]]$data$creators[[3]]$lastName
#> [1] "Laspisa"
#> 
#> 
#> [[1]]$data$creators[[4]]
#> [[1]]$data$creators[[4]]$creatorType
#> [1] "author"
#> 
#> [[1]]$data$creators[[4]]$firstName
#> [1] "Jason G."
#> 
#> [[1]]$data$creators[[4]]$lastName
#> [1] "Wallace"
#> 
#> 
#> 
#> [[1]]$data$abstractNote
#> [1] "Maize (Zea mays) is a multifaceted cereal grass used globally for nutrition, animal feed, food processing, and biofuels, and a model system in genetics research. Studying the maize microbiome sometimes requires its manipulation to identify the contributions of specific taxa and ecological traits (i.e., diversity, richness, network structure) to maize growth and physiology. Due to regulatory constraints on applying engineered microorganisms in field settings, greenhouse-based experimentation is often the first step for understanding the contribution of root-associated microbiota—whether natural or engineered—to plant phenotypes. In this protocol, we describe methods to inoculate maize with a specific microbiome as a tool for understanding the microbiota's influence on its host plant. The protocol involves removal of the native seed microbiome followed by inoculation of new microorganisms; separate protocols are provided for inoculations from pure culture, from soil slurry, or by mixing in live soil. These protocols cover the most common methods for manipulating the maize microbiome in soil-grown plants in the greenhouse. The methods outlined will ultimately result in rhizosphere microbial assemblages with varying degrees of microbial diversity, ranging from low diversity (individual strain and synthetic community [SynCom] inoculation) to high diversity (percent live inoculation), with the slurry inoculation method representing an “intermediate diversity” treatment."
#> 
#> [[1]]$data$publicationTitle
#> [1] "Cold Spring Harbor Protocols"
#> 
#> [[1]]$data$volume
#> [1] ""
#> 
#> [[1]]$data$issue
#> [1] ""
#> 
#> [[1]]$data$pages
#> [1] ""
#> 
#> [[1]]$data$date
#> [1] "2024-09-05"
#> 
#> [[1]]$data$series
#> [1] ""
#> 
#> [[1]]$data$seriesTitle
#> [1] ""
#> 
#> [[1]]$data$seriesText
#> [1] ""
#> 
#> [[1]]$data$journalAbbreviation
#> [1] "Cold Spring Harb Protoc"
#> 
#> [[1]]$data$language
#> [1] "en"
#> 
#> [[1]]$data$DOI
#> [1] "10.1101/pdb.prot108584"
#> 
#> [[1]]$data$ISSN
#> [1] "1940-3402, 1559-6095"
#> 
#> [[1]]$data$shortTitle
#> [1] ""
#> 
#> [[1]]$data$url
#> [1] "http://cshprotocols.cshlp.org/content/early/2024/09/05/pdb.prot108584"
#> 
#> [[1]]$data$accessDate
#> [1] "2024-09-19T04:03:28Z"
#> 
#> [[1]]$data$archive
#> [1] ""
#> 
#> [[1]]$data$archiveLocation
#> [1] ""
#> 
#> [[1]]$data$libraryCatalog
#> [1] "cshprotocols.cshlp.org"
#> 
#> [[1]]$data$callNumber
#> [1] ""
#> 
#> [[1]]$data$rights
#> [1] ""
#> 
#> [[1]]$data$extra
#> [1] "Publisher: Cold Spring Harbor Laboratory Press\nPMID: 39237453\nTLDR: Methods to inoculate maize with a specific microbiome as a tool for understanding the microbiota's influence on its host plant and resulting in rhizosphere microbial assemblages with varying degrees of microbial diversity are described.\ntitleTranslation: 操控玉米微生物群系"
#> 
#> [[1]]$data$tags
#> list()
#> 
#> [[1]]$data$collections
#> [[1]]$data$collections[[1]]
#> [1] "NVIWASQD"
#> 
#> 
#> [[1]]$data$relations
#> named list()
#> 
#> [[1]]$data$dateAdded
#> [1] "2024-09-19T04:03:28Z"
#> 
#> [[1]]$data$dateModified
#> [1] "2024-10-31T05:55:35Z"

# Get total number of items in a collection
num_all_items(client)
#> [[1]]
#> [[1]]$key
#> [1] "Z5NE7NV2"
#> 
#> [[1]]$version
#> [1] 21936
#> 
#> [[1]]$library
#> [[1]]$library$type
#> [1] "user"
#> 
#> [[1]]$library$id
#> [1] 62236
#> 
#> [[1]]$library$name
#> [1] "gaoch"
#> 
#> [[1]]$library$links
#> [[1]]$library$links$alternate
#> [[1]]$library$links$alternate$href
#> [1] "https://www.zotero.org/springgao"
#> 
#> [[1]]$library$links$alternate$type
#> [1] "text/html"
#> 
#> 
#> 
#> 
#> [[1]]$links
#> [[1]]$links$self
#> [[1]]$links$self$href
#> [1] "https://api.zotero.org/users/62236/items/Z5NE7NV2"
#> 
#> [[1]]$links$self$type
#> [1] "application/json"
#> 
#> 
#> [[1]]$links$alternate
#> [[1]]$links$alternate$href
#> [1] "https://www.zotero.org/springgao/items/Z5NE7NV2"
#> 
#> [[1]]$links$alternate$type
#> [1] "text/html"
#> 
#> 
#> 
#> [[1]]$meta
#> [[1]]$meta$creatorSummary
#> [1] "Raglin et al."
#> 
#> [[1]]$meta$parsedDate
#> [1] "2024-09-05"
#> 
#> [[1]]$meta$numChildren
#> [1] 2
#> 
#> 
#> [[1]]$data
#> [[1]]$data$key
#> [1] "Z5NE7NV2"
#> 
#> [[1]]$data$version
#> [1] 21936
#> 
#> [[1]]$data$itemType
#> [1] "journalArticle"
#> 
#> [[1]]$data$title
#> [1] "Manipulating the Maize (Zea mays) Microbiome"
#> 
#> [[1]]$data$creators
#> [[1]]$data$creators[[1]]
#> [[1]]$data$creators[[1]]$creatorType
#> [1] "author"
#> 
#> [[1]]$data$creators[[1]]$firstName
#> [1] "Sierra S."
#> 
#> [[1]]$data$creators[[1]]$lastName
#> [1] "Raglin"
#> 
#> 
#> [[1]]$data$creators[[2]]
#> [[1]]$data$creators[[2]]$creatorType
#> [1] "author"
#> 
#> [[1]]$data$creators[[2]]$firstName
#> [1] "Alonso"
#> 
#> [[1]]$data$creators[[2]]$lastName
#> [1] "Favela"
#> 
#> 
#> [[1]]$data$creators[[3]]
#> [[1]]$data$creators[[3]]$creatorType
#> [1] "author"
#> 
#> [[1]]$data$creators[[3]]$firstName
#> [1] "Daniel"
#> 
#> [[1]]$data$creators[[3]]$lastName
#> [1] "Laspisa"
#> 
#> 
#> [[1]]$data$creators[[4]]
#> [[1]]$data$creators[[4]]$creatorType
#> [1] "author"
#> 
#> [[1]]$data$creators[[4]]$firstName
#> [1] "Jason G."
#> 
#> [[1]]$data$creators[[4]]$lastName
#> [1] "Wallace"
#> 
#> 
#> 
#> [[1]]$data$abstractNote
#> [1] "Maize (Zea mays) is a multifaceted cereal grass used globally for nutrition, animal feed, food processing, and biofuels, and a model system in genetics research. Studying the maize microbiome sometimes requires its manipulation to identify the contributions of specific taxa and ecological traits (i.e., diversity, richness, network structure) to maize growth and physiology. Due to regulatory constraints on applying engineered microorganisms in field settings, greenhouse-based experimentation is often the first step for understanding the contribution of root-associated microbiota—whether natural or engineered—to plant phenotypes. In this protocol, we describe methods to inoculate maize with a specific microbiome as a tool for understanding the microbiota's influence on its host plant. The protocol involves removal of the native seed microbiome followed by inoculation of new microorganisms; separate protocols are provided for inoculations from pure culture, from soil slurry, or by mixing in live soil. These protocols cover the most common methods for manipulating the maize microbiome in soil-grown plants in the greenhouse. The methods outlined will ultimately result in rhizosphere microbial assemblages with varying degrees of microbial diversity, ranging from low diversity (individual strain and synthetic community [SynCom] inoculation) to high diversity (percent live inoculation), with the slurry inoculation method representing an “intermediate diversity” treatment."
#> 
#> [[1]]$data$publicationTitle
#> [1] "Cold Spring Harbor Protocols"
#> 
#> [[1]]$data$volume
#> [1] ""
#> 
#> [[1]]$data$issue
#> [1] ""
#> 
#> [[1]]$data$pages
#> [1] ""
#> 
#> [[1]]$data$date
#> [1] "2024-09-05"
#> 
#> [[1]]$data$series
#> [1] ""
#> 
#> [[1]]$data$seriesTitle
#> [1] ""
#> 
#> [[1]]$data$seriesText
#> [1] ""
#> 
#> [[1]]$data$journalAbbreviation
#> [1] "Cold Spring Harb Protoc"
#> 
#> [[1]]$data$language
#> [1] "en"
#> 
#> [[1]]$data$DOI
#> [1] "10.1101/pdb.prot108584"
#> 
#> [[1]]$data$ISSN
#> [1] "1940-3402, 1559-6095"
#> 
#> [[1]]$data$shortTitle
#> [1] ""
#> 
#> [[1]]$data$url
#> [1] "http://cshprotocols.cshlp.org/content/early/2024/09/05/pdb.prot108584"
#> 
#> [[1]]$data$accessDate
#> [1] "2024-09-19T04:03:28Z"
#> 
#> [[1]]$data$archive
#> [1] ""
#> 
#> [[1]]$data$archiveLocation
#> [1] ""
#> 
#> [[1]]$data$libraryCatalog
#> [1] "cshprotocols.cshlp.org"
#> 
#> [[1]]$data$callNumber
#> [1] ""
#> 
#> [[1]]$data$rights
#> [1] ""
#> 
#> [[1]]$data$extra
#> [1] "Publisher: Cold Spring Harbor Laboratory Press\nPMID: 39237453\nTLDR: Methods to inoculate maize with a specific microbiome as a tool for understanding the microbiota's influence on its host plant and resulting in rhizosphere microbial assemblages with varying degrees of microbial diversity are described.\ntitleTranslation: 操控玉米微生物群系"
#> 
#> [[1]]$data$tags
#> list()
#> 
#> [[1]]$data$collections
#> [[1]]$data$collections[[1]]
#> [1] "NVIWASQD"
#> 
#> 
#> [[1]]$data$relations
#> named list()
#> 
#> [[1]]$data$dateAdded
#> [1] "2024-09-19T04:03:28Z"
#> 
#> [[1]]$data$dateModified
#> [1] "2024-10-31T05:55:35Z"
```

### 搜索

``` r
# 获取所有保存的搜索
searches <- get_searches(client)

search_key = searches[[1]]$key

# 获取特定的搜索
search <- get_search(client, search_key)
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
item_key <- items[[1]]$key

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
