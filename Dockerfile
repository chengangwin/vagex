FROM centos:6

RUN yum update -y \
    && yum -y install wget vim tigervnc-server epel-release firefox \
    && yum -y groupinstall xfce \
    && yum clean all
ENV VNC_PW=xiaosong
RUN mkdir /root/.vnc/ \
    && wget http://fpdownload.macromedia.com/get/flashplayer/pdc/11.2.202.635/install_flash_player_11_linux.x86_64.tar.gz \
    && mkdir flash_player \
    && tar zxvf install_flash_player_11_linux.x86_64.tar.gz -C flash_player \
    && mkdir -p ~/.mozilla/plugins/ \
    && cp flash_player/libflashplayer.so ~/.mozilla/plugins/ \
    && rm -rf flash_player install_flash_player_11_linux.x86_64.tar.gz
EXPOSE 5901
COPY xstartup /root/.vnc/
COPY vnc.sh /opt/
RUN chmod +x /opt/vnc.sh /root/.vnc/xstartup /etc/X11/xinit/xinitrc \
    && echo "VNCSERVERS=\"1:root\"" >> /etc/sysconfig/vncservers \
    && echo "VNCSERVERARGS[1]=\"-geometry 1280x800 -depth 24\"" >> /etc/sysconfig/vncservers
ENTRYPOINT ["/opt/vnc.sh"]