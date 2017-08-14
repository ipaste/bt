FROM fedora:latest

MAINTAINER huaixiaoz "hello@ifnot.cc"

# Run updates
RUN rpm --rebuilddb && \
  dnf upgrade -yq && \
  dnf clean all
# Install package
RUN dnf install -yq iputils wget psmisc procps-ng && \
  dnf clean all

ARG isVersion=true
RUN curl -sSLO http://download.bt.cn/install/install.sh && \
  sed  -i "s/service\ bt/\/etc\/init.d\/bt/g" /install.sh && \
  sed -i "s/^autoSwap$//g" /install.sh && \
  yes | sh install.sh && \
  dnf clean all

EXPOSE 8888
VOLUME /www

WORKDIR /www
CMD /etc/init.d/bt start && touch '/tmp/panelExec.log' && tail -f '/tmp/panelExec.log'
