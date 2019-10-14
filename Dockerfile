FROM mcr.microsoft.com/dotnet/core/sdk:3.0

RUN curl https://dot.net/v1/dotnet-install.sh > dotnet-install.sh

RUN chmod +x ./dotnet-install.sh

RUN ./dotnet-install.sh --channel master --version 5.0.100-alpha1-013788 --install-dir /usr/share/dotnet
RUN ./dotnet-install.sh --version 3.0.0 --runtime dotnet --install-dir /usr/share/dotnet

RUN git clone --recursive --branch upstream-azure-signalr --depth 1 https://github.com/staff0rd/aspnetcore

WORKDIR /aspnetcore/src/SignalR/perf/benchmarkapps/Crankier

RUN dotnet build

ENTRYPOINT [ "dotnet", "/aspnetcore/artifacts/bin/Crankier/Debug/netcoreapp5.0/Crankier.dll" ]
