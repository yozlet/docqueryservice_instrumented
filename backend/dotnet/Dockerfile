# Use the official .NET SDK image to build the project
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src

# Copy csproj and restore dependencies
COPY ["DocQuery.Api/DocQuery.Api.csproj", "DocQuery.Api/"]
RUN dotnet restore "DocQuery.Api/DocQuery.Api.csproj"

# Copy the rest of the files and build
COPY . .
RUN dotnet build "DocQuery.Api/DocQuery.Api.csproj" -c Release -o /app/build

# Publish the application
FROM build AS publish
RUN dotnet publish "DocQuery.Api/DocQuery.Api.csproj" -c Release -o /app/publish

# Build the runtime image
FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS final
WORKDIR /app
COPY --from=publish /app/publish .

# Expose port
EXPOSE 80

# Set entry point
ENTRYPOINT ["dotnet", "DocQuery.Api.dll"]

