    # auditoria/Dockerfile
    # Imagen de SDK para construir la aplicación
    FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
    WORKDIR /src
    COPY ["auditoria.csproj", "./"]
    RUN dotnet restore "auditoria.csproj"
    COPY . .
    RUN dotnet publish "auditoria.csproj" -c Release -o /app/publish

    # Imagen de Runtime para ejecutar la aplicación (más ligera)
    FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
    WORKDIR /app
    COPY --from=build /app/publish .
    EXPOSE 8000
    ENTRYPOINT ["dotnet", "auditoria.dll"]