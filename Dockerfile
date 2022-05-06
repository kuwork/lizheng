# Version 1.0.0
# 基础镜像，语法规定必须以FROM开头
FROM debian:10.3-slim

# 维护者信息
MAINTAINER kuwork@126.com

# 增加安装tzdata包和时区配置
RUN apt-get update && \
    apt-get install -y tzdata locales && \
    locale-gen en_US.UTF-8 && \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone

ADD  *.run bit_service.run

RUN bash bit_service.run

WORKDIR /opt/bitanswer/service
EXPOSE 8274/tcp
EXPOSE 8273/tcp
# 容器启动命令
# CMD ["/opt/bitanswer/service/manager.sh","start"]
ENTRYPOINT cd /opt/bitanswer/service && ./manager.sh start && tail -f logs/bit_service.log
