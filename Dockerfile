# https://hub.docker.com/_/microsoft-dotnet
FROM mcr.microsoft.com/dotnet/sdk:6.0-alpine AS build
RUN apk add --update npm
WORKDIR /source

# copy csproj and restore as distinct layers
COPY *.csproj .
# RUN dotnet restore -r linux-musl-arm64
RUN dotnet restore -r linux-musl-arm64 /p:PublishReadyToRun=true

# copy everything else and build app
COPY . .
# RUN dotnet publish -c release -o /app -r linux-musl-x64 --self-contained false --no-restore
RUN dotnet publish -c release -o /app -r linux-musl-x64 --self-contained true --no-restore /p:PublishTrimmed=true /p:PublishReadyToRun=true /p:PublishSingleFile=true

# final stage/image
FROM mcr.microsoft.com/dotnet/aspnet:6.0-alpine-amd64
WORKDIR /app
COPY --from=build /app ./

# configure kestrel listening port
ENV ASPNETCORE_URLS=http://+:5050
ENV ASPNETCORE_ENVIRONMENT=Production

# this should be the dll
#ENTRYPOINT ["dotnet", "./Dnw.React.dll", "--server.urls", "http://0.0.0.0:5050"]
#ENTRYPOINT ["dotnet", "./Dnw.React.dll"]
ENTRYPOINT ["./Dnw.React"]
