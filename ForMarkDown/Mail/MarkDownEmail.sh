#!/bin/sh
# 用于调用 sendEmail.py 发送 markdown sendEmail
# 使用 bash 来调用本脚本

path=$(dirname $0)
cd ${path}

python sendEmail.py 