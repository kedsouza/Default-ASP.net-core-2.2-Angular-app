# BUILD CONTAINER
FROM mcr.microsoft.com/dotnet/core/sdk:2.2 AS build-env

# Install Node JS required to build
RUN apt-get update \ 
	&& curl -sL https://deb.nodesource.com/setup_10.x | bash - \
	&& apt-get install -y --no-install-recommends \
	apt-utils \
 	nodejs \
	npm

WORKDIR /build

# Copy csproj and restore as distinct layers
COPY *.csproj ./
RUN dotnet restore

# Copy everything else and build
COPY . ./

RUN dotnet publish -c Release -o $PWD/app

# RUN CONTAINER
FROM mcr.microsoft.com/dotnet/core/aspnet:2.2

ENV HOME /app

COPY --from=build-env /build/app /app

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

USER dotnet
WORKDIR /home/site/wwwroot

ENTRYPOINT ["/bin/cmd.sh"]
