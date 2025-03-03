

FROM mcr.microsoft.com/dotnet/skd:8.0 AS build
WORKDIR /app

COPY *.csproj .
RUN dotnet restore

COPY .. 
RUN dotnet publish -c Release -o /out

FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /out .

EXPOSE 80

ENTRYPOINT ["dotnet", "DockerMVC.dll"]
