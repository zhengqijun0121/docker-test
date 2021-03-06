FROM ubuntu:18.04

# maintainer
MAINTAINER zhengqijun zhengqijun0121@qq.com

# set shell
ENV SHELL=/bin/bash

# equipment
RUN apt-get update && \
    apt-get install -y --no-install-recommends --allow-downgrades --fix-missing \
    software-properties-common \
    git-core \
    curl \
    wget \
    nodejs \
    npm

# install & config git
RUN add-apt-repository -y ppa:git-core/ppa && \
    apt-get update -y && \
    apt-get install -y git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    git config --global ssh.variant ssh && \
    git config --global user.email "zhengqijun0121@qq.com" && \
    git config --global user.name "zhengqijun"

# hexo-cli
RUN npm install npm -g && \
    npm install n -g && \
    n stable && \
    PATH="$PATH" && \
    npm install hexo-cli -g

# set user
ENV HOME /home/zhengqijun
RUN groupadd -g 10000 zhengqijun
RUN useradd -c "zhengqijun user" -d $HOME -u 10000 -g 10000 -m zhengqijun
USER zhengqijun:zhengqijun
WORKDIR /home/zhengqijun

# npm
RUN mkdir -p Workspace/Blog && \
    cd Workspace/Blog && \
    hexo init . && \
    npm install && \
    npm install hexo-generator-sitemap --save && \
    npm install hexo-generator-feed --save && \
    npm install hexo-deployer-git --save

# EOF

