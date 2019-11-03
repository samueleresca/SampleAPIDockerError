FROM mcr.microsoft.com/dotnet/core/aspnet:3.0.0 AS base
WORKDIR /app

FROM mcr.microsoft.com/dotnet/core/sdk:3.0 AS build
WORKDIR /project
COPY ["SampleAPI/SampleAPI.csproj", "SampleAPI/"]
COPY . .
WORKDIR "/project/SampleAPI"
RUN dotnet build "SampleAPI.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "SampleAPI.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "SampleAPI.dll"]