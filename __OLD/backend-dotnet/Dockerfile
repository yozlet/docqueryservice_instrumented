# Use the official .NET 9.0 runtime as a parent image
FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS base
WORKDIR /app


# Use the .NET SDK for building
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
ARG BUILD_CONFIGURATION=Development
WORKDIR /src
COPY ["DocumentQueryService.Api.csproj", "DocumentQueryService.Api/"]
RUN dotnet restore "DocumentQueryService.Api/DocumentQueryService.Api.csproj"
WORKDIR "/src/DocumentQueryService.Api"
COPY . .
RUN dotnet build "DocumentQueryService.Api.csproj" -c $BUILD_CONFIGURATION -o /app/build

FROM build AS publish
ARG BUILD_CONFIGURATION=Development
RUN dotnet publish "DocumentQueryService.Api.csproj" -c $BUILD_CONFIGURATION -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "DocumentQueryService.Api.dll"]