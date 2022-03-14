#!/bin/bash
name=discovery-guide-service
echo "kill旧的服务 $name"
msg=`ps -ef | grep $name |grep -v 'grep'`
echo "$msg";
for process in `ps -ef | grep $name |grep -v 'grep'| awk '{print $2}'`
do
 echo "kill $process";
 kill -9 $process;
 echo 'kill 成功'
done

echo 'kill旧的服务完成'
 
echo '启动项目'

nohup java -jar  -Xms128m -Xmx128m -Dspring.profiles.active=a1 /root/DiscoveryGuide/$name/target/$name-1.0.0.jar > log.out  2>&1 &

echo "tail -f  /root/DiscoveryGuide/log.out"
echo '脚本执行结束，请等待项目启动'
tail -f /root/DiscoveryGuide/log.out
