#!/bin/bash
#Enter the current directory And automatically or jar package
cd /opt/defi-backend/04-defi-scan-service
APP_HOME=`pwd`

APP_NAME="defi-scan-service"
SERVICE_NAME=$APP_NAME  
PID_NAME=$SERVICE_NAME.pid
JAR_FILE="scan-service.jar"

#Use instructions, used to prompt input parameters
usage() {
    echo "Usage: sh robotcenter.sh [start|stop|restart|status]"
    exit 1
}
 
#Check if the program is running
is_exist(){
  pid=`ps -ef|grep $APP_NAME|grep -v grep|awk '{print $2}'`
  #Return if not exist1, There is return0     
  if [ -z "${pid}" ]; then
   return 1
  else
    return 0
  fi
}
 
#Start method
start(){
  is_exist
  if [ $? -eq 0 ]; then
    echo "${APP_NAME} is already running. pid=${pid}"
  else
    nohup java -Xms128m -Xmx1g -jar  $JAR_FILE --spring.config.import=file:.env.properties & echo $! > $PID_NAME
    echo "..."
    sleep 2
    echo "..."
    sleep 3
    is_exist
    if [ $? -eq 0 ]; then
      echo "${APP_NAME} is running success. pid=${pid}"
    fi
  fi
}
 
#Stop method
stop(){
  is_exist
  if [ $? -eq "0" ]; then
    kill -9 $pid
    rm $PID_NAME
    echo "..."
    sleep 2
    is_exist
    if [ $? -eq 0 ]; then
      echo "${APP_NAME} still in the running. pid=${pid}"
    else
      echo "${APP_NAME} has stopped running."
    fi
  else
    echo "${APP_NAME} is not running"
  fi  
}
 
#Output running status
status(){
  is_exist
  if [ $? -eq "0" ]; then
    echo "${APP_NAME} is running. Pid is ${pid}"
  else
    echo "${APP_NAME} is NOT running."
  fi
}
 
#Reboot
restart(){
  stop
  #sleep 5
  start
}
 
#According to the input parameters, choose to execute the corresponding method, if not input, execute the instructions
case "$1" in
  "start")
    start
    ;;
  "stop")
    stop
    ;;
  "status")
    status
    ;;
  "restart")
    restart
    ;;
  *)
    usage
    ;;
esac