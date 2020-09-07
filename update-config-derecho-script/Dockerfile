FROM poanpan/derecho-dev:v1

LABEL AUTHER=myles.l.pan@gmail.com

# configure derecho and cascade
COPY config/ /root/config
RUN ["chmod", "+x", "/root/config/config-derecho.sh"]