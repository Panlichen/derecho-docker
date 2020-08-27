FROM poanpan/derecho-dev:v1

LABEL AUTHER=myles.l.pan@gmail.com

COPY pull-and-rebuild.sh /root/upgrade/pull-and-rebuild.sh

RUN ["chmod", "+x", "/root/upgrade/pull-and-rebuild.sh"]
RUN ["/root/upgrade/pull-and-rebuild.sh"]