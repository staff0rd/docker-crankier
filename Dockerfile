FROM mcr.microsoft.com/dotnet/core/sdk:3.0

RUN curl https://dot.net/v1/dotnet-install.sh > dotnet-install.sh

RUN chmod +x ./dotnet-install.sh

RUN ./dotnet-install.sh --channel master --version 3.0.100-preview6-012264 --install-dir /usr/share/dotnet
RUN ./dotnet-install.sh --version 3.0.0-preview8-27919-09 --runtime dotnet --install-dir /usr/share/dotnet

RUN git clone --recursive --branch crankier-server --depth 1 https://github.com/staff0rd/aspnetcore

WORKDIR /aspnetcore/src/SignalR/perf/benchmarkapps/Crankier

RUN dotnet build

ENTRYPOINT [ "dotnet", "/aspnetcore/artifacts/bin/Crankier/Debug/netcoreapp3.0/Crankier.dll" ]
