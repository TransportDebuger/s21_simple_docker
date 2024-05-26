FROM nginx:latest

USER root

COPY ./nginx-1.conf /etc/nginx/nginx.conf
COPY ./fcgi-app.c /etc/nginx/fcgi-app.c
COPY ./t4init.sh /etc/nginx/init.sh

RUN apt-get update &&  \
    apt-get install -y gcc spawn-fcgi libfcgi-dev && \ 
    rm -rf /var/lib/apt/lists/*;

RUN gcc /etc/nginx/fcgi-app.c -o /etc/nginx/webserver -l fcgi; \
    chmod +x /etc/nginx/init.sh; \
    chown -R nginx:nginx /etc/nginx/nginx.conf; \
    chown -R nginx:nginx /var/cache/nginx; \
    chown -R nginx:nginx /home; \
    touch /var/run/nginx.pid; \
    chown -R nginx:nginx /var/run/nginx.pid; \
    chmod u-s /usr/bin/gpasswd; \
    chmod u-s /usr/bin/newgrp; \
    chmod u-s /bin/su; \
    chmod u-s /bin/mount; \
    chmod u-s /bin/umount; \
    chmod u-s /usr/bin/chsh; \
    chmod u-s /usr/bin/chfn; \
    chmod u-s /usr/bin/chsh; \
    chmod 255 /usr/bin/expiry; \
    chmod 255 /usr/bin/wall; \
    chmod 255 /sbin/unix_chkpwd; \
    chmod 255 /usr/bin/chage; \
    chmod 755 /usr/bin/passwd

USER nginx

HEALTHCHECK --interval=5m --timeout=3s CMD curl -f http://localhost:81/ || exit 1
ENTRYPOINT [ "/etc/nginx/init.sh" ]