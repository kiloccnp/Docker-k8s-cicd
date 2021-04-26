#!/bin/sh
# Maintenace by kilo
SERVICE_NAME=Your_Service_Name 
PATH_TO_JAR=/usr/Name_of_User/MyJavaApplication.jar 
PID_PATH_NAME=/tmp/Service_Name-pid

#Check if the program is running
is_exist(){
  pid=`ps -ef|grep $SERVICE_NAME|grep -v grep|awk '{print $2}'`
  #Return if not exist1, There is return0     
  if [ -z "${pid}" ]; then
   return 1
  else
    return 0
  fi
}


case $1 in 
start)
       echo "Starting $SERVICE_NAME ..."
  if [ ! -f $PID_PATH_NAME ] || [$is_exist == 0]; then 
       nohup java -jar $PATH_TO_JAR /tmp 2>> /dev/null >>/dev/null &      
                   echo $! > $PID_PATH_NAME  
       echo "$SERVICE_NAME started ..."         
  else 
       echo "$SERVICE_NAME is already running ..."
  fi
;;
stop)
  if [ -f $PID_PATH_NAME ] || [$is_exist == 1] ; then
         PID=$(cat $PID_PATH_NAME);
         echo "$SERVICE_NAME stoping ..." 
         kill $PID;
         sleep 3         
         echo "$SERVICE_NAME stopped ..." 
         rm $PID_PATH_NAME       
  else          
         echo "$SERVICE_NAME is not running ..."   
  fi    
;;    
restart)  
  if [ -f $PID_PATH_NAME ]; then 
      PID=$(cat $PID_PATH_NAME);    
      echo "$SERVICE_NAME stopping ..."; 
      kill $PID;           
      echo "$SERVICE_NAME stopped ...";  
      rm $PID_PATH_NAME     
      echo "$SERVICE_NAME starting ..."  
      nohup java -jar $PATH_TO_JAR /tmp 2>> /dev/null >> /dev/null &            
      echo $! > $PID_PATH_NAME  
      echo "$SERVICE_NAME started ..."    
  else           
      echo "$SERVICE_NAME is not running ..."    
     fi     ;;
 esac