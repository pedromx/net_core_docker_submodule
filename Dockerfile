#Depending on the operating system of the host machines(s) that will build or run the containers, the image specified in the FROM statement may need to be changed.
#For more information, please see https://aka.ms/containercompat

#FROM mcr.microsoft.com/dotnet/core/aspnet:2.2-nanoserver-1809 AS base
#FROM mcr.microsoft.com/dotnet/core/runtime:2.2 AS base
FROM mcr.microsoft.com/dotnet/core/aspnet:2.2 AS base
WORKDIR /app
EXPOSE 80

#FROM mcr.microsoft.com/dotnet/core/sdk:2.2-nanoserver-1809 AS build
FROM mcr.microsoft.com/dotnet/core/sdk:2.2 AS build

WORKDIR /src
COPY ["net_core_project.csproj", "./"]
RUN dotnet restore "./net_core_project.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "net_core_project.csproj" -c Release -o /app

FROM build AS publish
RUN dotnet publish "net_core_project.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "net_core_project.dll"]

 
#docker build -t net_core_app:dev .
#docker run --rm -d -p 80:80/tcp 79fea49cedd7 => (image id)


