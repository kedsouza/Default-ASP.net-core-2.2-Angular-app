FROM mcr.microsoft.com/dotnet/core/aspnet:2.2

ENV HOME /app

COPY /app /app

RUN groupadd -r dotnet && useradd -m -g dotnet dotnet

COPY cmd.sh /bin/cmd.sh

RUN update-ca-certificates

RUN chmod -R 0744 /app && \
	chown -R dotnet:dotnet /app && \
	chmod a+rwx /bin/cmd.sh

EXPOSE 8080

ENV PORT 8080
ENV WEBSITE_ROLE_INSTANCE_ID localRoleInstance
ENV WEBSITE_INSTANCE_ID localInstance
ENV PATH ${PATH}:/home/site/wwwroot
ENV ASPNETCORE_URLS=http://0.0.0.0:8080
ENV ASPNETCORE_FORWARDEDHEADERS_ENABLED=true

USER root
WORKDIR /home/site/wwwroot

ENTRYPOINT ["/bin/cmd.sh"]
