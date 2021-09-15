FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && \ 
apt-get install -y nodejs
WORKDIR /source

# Copy csproj and restore as distinct layers
COPY *.sln .
COPY DotnetTemplate.Web/*.csproj ./DotnetTemplate.Web/


# Copy everything else and build
COPY DotnetTemplate.Web/. ./DotnetTemplate.Web/
WORKDIR /source/DotnetTemplate.Web
RUN dotnet publish -c release -o /app

# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:5.0
WORKDIR /app
COPY --from=build /app ./
ENTRYPOINT ["dotnet", "DotnetTemplate.Web.dll"]