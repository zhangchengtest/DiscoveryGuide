echo -e '\033[32m'
echo '============================================================='
echo '$                                                           $'
echo '$                     Nepxion Discovery                     $'
echo '$                                                           $'
echo '$                                                           $'
echo '$                                                           $'
echo '$  Nepxion Studio All Right Reserved                        $'
echo '$  Copyright (C) 2017-2050                                  $'
echo '$                                                           $'
echo '============================================================='

echo -n $'\e'"]0;Nepxion Discovery Guide [Service B1]"$'\a'

PROJECT_NAME=discovery-guide-service

DOCKER_HOST=tcp://localhost:2375
# DOCKER_CERT_PATH=/User/Neptune/.docker/machine/certs
IMAGE_NAME=guide-service-b1
MAIN_CLASS='com.nepxion.discovery.guide.service.DiscoveryGuideServiceB1'
MACHINE_PORT=4001
CONTAINER_PORT=4001
MIDDLEWARE_HOST=10.0.75.1
RUN_MODE='-i -t'
# RUN_MODE=-d

if [ ! -d ${PROJECT_NAME}/target];then
rmdir /s/q ${PROJECT_NAME}/target
fi

# 执行相关模块的Maven Install
mvn clean install -DskipTests -pl ${PROJECT_NAME} -am -DMainClass=${MAIN_CLASS}

# 停止和删除Docker容器
docker stop ${IMAGE_NAME}
# docker kill ${IMAGE_NAME}
docker rm ${IMAGE_NAME}

# 删除Docker镜像
docker rmi ${IMAGE_NAME}

cd ${PROJECT_NAME}

# 安装Docker镜像
mvn package docker:build -DskipTests -DImageName=${IMAGE_NAME} -DExposePort=${CONTAINER_PORT}

# 安装和启动Docker容器，并自动执行端口映射
docker run --env middleware.host=${MIDDLEWARE_HOST} ${RUN_MODE} -e TZ="Asia/Shanghai" -p ${MACHINE_PORT}:${CONTAINER_PORT} -h ${IMAGE_NAME} --name ${IMAGE_NAME} ${IMAGE_NAME}:latest

function pause(){
  echo 'Press any key to continue...'
  read -n 1 -p "$*" str_inp
  if [ -z "$str_inp" ];then
    str_inp=1
  fi
    if [ $str_inp != '' ];then
      echo -ne '\b \n'
    fi
}

pause