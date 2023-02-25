FROM ubuntu:20.04

ENV USER docker
ENV GROUP docker
ENV NGINX_VERSION 1.22.1
ENV ALPINE_VERSION 3.6
ENV ALPINE_ARCH x86_64
ENV REPO_ROOT /debian-repo

COPY files/entrypoint.sh /bin/entrypoint.sh
COPY files/debian-repo-index.sh /bin/debian-repo-index
COPY files/nginx.conf.erb /etc/nginx/nginx.conf.erb

RUN apt-get update \
   && apt-get install -y dpkg-dev sudo ruby wget \
   && wget https://nginx.org/packages/ubuntu/pool/nginx/n/nginx/nginx_${NGINX_VERSION}-1~bionic_amd64.deb \
   && sudo dpkg -i nginx_${NGINX_VERSION}-1~bionic_amd64.deb \
   && rm -f nginx_${NGINX_VERSION}-1~bionic_amd64.deb \
   && adduser ${USER} \
   && usermod -aG sudo ${USER} \
   && usermod -aG ${GROUP} ${USER} \
   && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers \
   && chown -R ${USER}:${GROUP} /etc/default/nginx* \
   && chown -R ${USER}:${GROUP} /etc/init.d/nginx* \
   && chown -R ${USER}:${GROUP} /etc/nginx* \
   && chown -R ${USER}:${GROUP} /usr/lib/nginx* \
   && chown -R ${USER}:${GROUP} /usr/sbin/nginx* \
   && chown -R ${USER}:${GROUP} /usr/share/nginx* \
   && chown -R ${USER}:${GROUP} /var/cache/nginx* \
   && chown -R ${USER}:${GROUP} /var/log/nginx* \
   && chown -R ${USER}:${GROUP} /bin/entrypoint.sh \
   && chmod +x /bin/entrypoint.sh \
   && chown -R ${USER}:${GROUP} /bin/debian-repo-index \
   && chmod +x /bin/debian-repo-index \
   && chown -R ${USER}:${GROUP} /etc/nginx/nginx.conf.erb \
   && rm -f /var/run/nginx.pid \
   && rm -f /run/nginx.pid \
   && chown -R ${USER}:${GROUP} /var/run \
   && chown -R ${USER}:${GROUP} /run \
   && chown -R ${USER}:${GROUP} /var/log/nginx

EXPOSE 8443
EXPOSE 8080

USER $USER

ENTRYPOINT /bin/entrypoint.sh
