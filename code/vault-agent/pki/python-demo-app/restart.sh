#!/bin/bash

echo -e "\n***----------    Restarting Demo App : Started   ------------***"
echo `date`

echo -e "\nGetting PID"
PID=`ps -eaf |grep -i "/src/run.py"|grep -v sh|grep -v grep|awk '{print $2}'`
echo PID="$PID"
echo "Killing PID : $PID"
kill $PID

echo -e "\nRestarting demo-app"
nohup /usr/sbin/start-app.sh > /root/python-demo-app/src/app.log 2>&1 &

echo -e "\n***----------    Restarting Demo App : Completed   ------------***"
echo `date`
echo -e "logs location : /root/python-demo-app/src/app.log \n"

