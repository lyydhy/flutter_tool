<!--
 * @Author: your name
 * @Date: 2021-07-30 18:21:54
 * @LastEditTime: 2021-07-30 18:29:55
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: \env\README.md
-->
# flutter_tool
Flutter多渠道打包工具

# 使用教程
- flutter根目录下创建.env.[name] 文件
- 文件内容必须要有APP_CHANNEL=[渠道名] APP_NAME=[app名字]
- flutter 里面就用 const String.fromEnvironment('APP_CHANNEL', defaultValue: 'unkonw');获取就行了
- 打包后会自动把安装包复制到桌面上 以app名字为文件夹 在里面以渠道名为文件夹 打包后的文件会复制到这里  目前windows 应该都可以  其他系统的自测