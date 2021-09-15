FROM mcr.microsoft.com/dotnet/sdk:5.0
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && \ 
apt-get install -y nodejs
COPY . /app
WORKDIR /app
RUN dotnet build --configuration Release
WORKDIR /app/DotnetTemplate.Web
RUN npm install
RUN npm run build 
ENTRYPOINT ["dotnet", "run"]