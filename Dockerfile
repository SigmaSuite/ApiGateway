FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build-env


WORKDIR /apigateway
COPY . .
EXPOSE 7000
ENV ASPNETCORE_URLS="http://*:7000"

RUN dotnet restore
RUN dotnet publish -c Development -o out

FROM mcr.microsoft.com/dotnet/nightly/aspnet:5.0
WORKDIR /apigateway
COPY --from=build-env /apigateway/out .
ENTRYPOINT ["dotnet", "ApiGateway.dll"]