#!/usr/bin/env python
#encoding:utf-8
# 实现邮件发送 MarkDown

import sys, os, smtplib, ConfigParser, markdown
from email.MIMEMultipart import MIMEMultipart
from email.MIMEText import MIMEText
from email.MIMEBase import MIMEBase
from email import Encoders

def getOutputContent(name):
    f = open(name, 'r')
    data = f.read()
    f.close()
    result = markdown.markdown(data)
    print result
    return result

def send():
    config = ConfigParser.ConfigParser()
    config.read("default.cfg")

    subject = 'email test'
    server = config.get('email','server')
    username = config.get('email','username')
    password = config.get('email','password')
    sendTo = config.get('email','sendTo')

    msg = MIMEMultipart()
    msg['Subject'] = subject
    msg['From'] = username
    msg['To'] = sendTo

    content = MIMEText(getOutputContent('/Users/chenzhiying/Desktop/markDowntest.md'), 'html', 'utf-8')
    msg.attach(content)

    # try:
    #     smtpObj = smtplib.SMTP() 
    #     smtpObj.connect(server, 25)    # 25 为 SMTP 端口号
    #     smtpObj.login(username,password)  
    #     smtpObj.sendmail(username, sendTo, msg.as_string())
    #     print "邮件发送成功"
    # except smtplib.SMTPException:
    #     print "Error: 无法发送邮件"



if __name__ == '__main__':
    #check input params

    # fix: Markdown only accepts unicode input!
    reload(sys)  
    sys.setdefaultencoding('utf8')

    send()