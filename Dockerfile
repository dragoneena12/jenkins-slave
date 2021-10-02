FROM docker:20.10.8

LABEL maintainter="dragoneena12"

RUN apk update \
 && apk --no-cache add \
      openjdk11-jre-headless \
      openssh-server \
 && rm -rf /var/cache/apk/*

RUN ssh-keygen -A
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin prohibit-password/' /etc/ssh/sshd_config
RUN sed -i 's/#Port 22/Port 20022/' /etc/ssh/sshd_config
COPY ./key.pub /root/.ssh/authorized_keys

EXPOSE 20022
CMD ["/usr/sbin/sshd", "-D"]
