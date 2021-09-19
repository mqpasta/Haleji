#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:5.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /src
COPY ["Haleji.Web/Haleji.Web.csproj", "Haleji.Web/"]
COPY ["Haleji.BusinessObjects/Haleji.BusinessObjects.csproj", "Haleji.BusinessObjects/"]
COPY ["Haleji.RepositoryBase/Haleji.RepositoryBase.csproj", "Haleji.RepositoryBase/"]
COPY ["Haleji.BusinessLogic/Haleji.BusinessLogic.csproj", "Haleji.BusinessLogic/"]
COPY ["Haleji.FakeRepository/Haleji.FakeRepository.csproj", "Haleji.FakeRepository/"]
COPY ["Haleji.SqlRepository/Haleji.SqlRepository.csproj", "Haleji.SqlRepository/"]
COPY ["qaimpasta.Common.DAL/Irada.Common.DAL.csproj", "qaimpasta.Common.DAL/"]
RUN dotnet restore "Haleji.Web/Haleji.Web.csproj"
COPY . .
WORKDIR "/src/Haleji.Web"
RUN dotnet build "Haleji.Web.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "Haleji.Web.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "Haleji.Web.dll"]