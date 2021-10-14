# // flutter_tool.sh
###
# @Author: your name
# @Date: 2021-07-16 18:05:05
 # @LastEditTime: 2021-07-28 13:53:44
 # @LastEditors: Please set LastEditors
# @Description: In User Settings Edit
# @FilePath: \puzzlec:\Users\1111\Music\env\flutter_tool.sh
###

#!/bin/bash
# 引导图
function welcome() {
  echo ""
  echo "欢迎使用 Flutter 多环境打包工具"
  # echo "=================================="
  echo "===================================================
‖                                                 ‖
‖  #       #   #  #   #  #####    #    #  #   #   ‖
‖  #        # #    # #   #     #  #    #   # #    ‖
‖  #         #      #    #     #  ######    #     ‖
‖  #         #      #    #     #  #    #    #     ‖
‖  #         #      #    #     #  #    #    #     ‖
‖  #######   #      #    #####    #    #    #     ‖
‖                                                 ‖
===================================================                             
"
  echo ""
}
welcome
# 具体打包命令
function build() {
  file=$HOME/Desktop/flutterBuild/$appname/$channel/
  flutter build apk $DART_DEFINES --split-per-abi
  echo ""
  echo "打包完成"
  cd $homePwd/build/app/outputs/flutter-apk/
  if [ -d "$file" ]; then
    cpExport
  else
    mkdir -p $file
    cpExport
  fi
  # echo $channel
}
# 复制和打开目录
function cpExport() {
  cp -R *.apk $file
  # cd $file
  # if [[ ! $(uname -s | grep NT) = "" ]]; then
  #   start .
  # else
  #   open .
  # fi
  # cd -
}
# 检查所有环境
function listEnvAll() {
  count=-1
  for entry in .env.*; do
    # if [ ${entry:5} != "dev" ]; then
    envArr[$((count = count + 1))]=${entry:5}
    # fi
  done
}
# 指定环境的用法
function isEnv() {
  VARS=($(cut -d ' ' -f1 $homePwd/.env.$MODEL))
  DART_DEFINES=""
  for ((i = 0; i < ${#VARS[@]}; i++)); do
    DART_DEFINES+=" --dart-define=${VARS[i]}"
    if [ "${VARS[i]:0:11}" = "APP_CHANNEL" ]; then
      channel=${VARS[i]:12}
    fi
    if [ "${VARS[i]:0:8}" = "APP_NAME" ]; then
      appname=${VARS[i]:9}
    fi
    if [ "${VARS[i]:0:7}" = "APP_ENV" ]; then
      appenv=${VARS[i]:8}
    fi
  done

  # 运行命令
  if [ "$1" = "run" ]; then
    flutter $1 $DART_DEFINES
  fi
  # 打包命令
  if [ "$1" = "build" ]; then
    echo ""
    echo "============================= 我是分割线 ============================="
    echo ""
    echo "开始打包"$appname"的"$channel"渠道，环境为"$appenv
    echo ""
    build
  fi
}
# 未指定环境
function noEnv() {
  echo "查找到以下环境=======================>"
  echo ""
  i=-1
  for v in ${envArr[@]}; do
    echo $((i = i + 1))"."$v
  done
  echo "99.全部打包"
  echo ""
  read -p "请输入对应下标，执行对应环境:" number
  if [[ $number =~ ^[0-9]+$ ]]; then
    if [ $number -lt ${#envArr[@]} -a $number -gt -1 ]; then
      MODEL=${envArr[$number]}
      isEnv $1
    else
      if [[ "$number" == "99" ]]; then
        for v in ${envArr[@]}; do
          MODEL=$v
          isEnv $1
        done
      fi
    fi
  else
    echo "请输入数字"
  fi
}
# 所有环境数组
envArr=()

listEnvAll
# 渠道
channel=""
# app名字
appname=""
# 环境
appenv=""
# 保存当前工作目录
homePwd=$(pwd)
# 判断 执行参数
if [[ "$1" == "" ]]; then
  echo "请输入执行参数 run 或者 build"
  exit
fi
# 检测是否有环境文件
if [ ${#envArr[@]} = 0 ]; then
  echo "未检测到环境文件"
  exit
fi

for i in "$@"; do
  case $i in
  --model=*)
    MODEL="${i#*=}"
    ;;
  *)
    # unknown option
    ;;
  esac
done
# 判断是否指定了具体环境
if [[ $MODEL != "" ]]; then
  isEnv $1
else
  echo "未指定具体环境，正查找所有环境........"
  echo ""
  noEnv $1
fi
