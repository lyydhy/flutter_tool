<!--
 * @Author: your name
 * @Date: 2021-07-30 18:21:54
 * @LastEditTime: 2021-07-30 18:27:07
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: \env\README.md
-->
# flutter_tool
Flutter多渠道打包工具

# 使用教程
- flutter根目录下创建.env.[name] 文件
- 文件内容必须要有APP_CHANNEL=[渠道名]
- flutter 里面就用 const String.fromEnvironment('APP_CHANNEL', defaultValue: 'unkonw');获取就行了