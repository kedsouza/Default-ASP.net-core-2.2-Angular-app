FROM mcr.microsoft.com/dotnet/core/aspnet:2.2

ENV HOME /app

COPY /app /app

RUN groupadd -r dotnet && useradd -m -g dotnet dotnet

COPY cmd.sh /bin/cmd.sh

RUN update-ca-certificates

RUN chmod -R 0744 /app && \
	chown -R dotnet:dotnet /app && \
	chmod a+rwx /bin/cmd.sh

RUN apt-get update \
	&& apt-get install -y dnsutils openssh-server sudo strace \
	&& echo "root:Docker!" | chpasswd \
	&& echo "dotnet   ALL=(ALL:ALL) NOPASSWD: /usr/sbin/service ssh start,/usr/sbin/service ssh stop, /usr/sbin/service ssh status, /etc/init.d/ssh start, /etc/init.d/ssh stop, /etc/init.d/ssh status" >> /etc/sudoers \

COPY sshd_config /etc/ssh 

RUN chmod a+w /etc/ssh/sshd_config


ENV PORT 8080

EXPOSE 8080 $SSH_PORT

ENV WEBSITE_ROLE_INSTANCE_ID localRoleInstance
ENV WEBSITE_INSTANCE_ID localInstance
ENV PATH ${PATH}:/home/site/wwwroot
ENV ASPNETCORE_URLS=http://0.0.0.0:8080
ENV ASPNETCORE_FORWARDEDHEADERS_ENABLED=true

USER dotnet
WORKDIR /home/site/wwwroot

ENTRYPOINT ["/bin/cmd.sh"]
