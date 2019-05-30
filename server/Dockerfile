FROM mcr.microsoft.com/dotnet/core/sdk:3.0

RUN curl https://dot.net/v1/dotnet-install.sh > dotnet-install.sh

RUN chmod +x ./dotnet-install.sh

RUN ./dotnet-install.sh --channel master --version 3.0.100-preview6-011744 --install-dir /usr/share/dotnet

RUN git clone --recursive --depth 1 https://github.com/staff0rd/aspnetcore

WORKDIR /aspnetcore/src/SignalR/perf/benchmarkapps/BenchmarkServer

RUN dotnet build

ENTRYPOINT [ "dotnet", "bin/Debug/netcoreapp3.0/BenchmarkServer.dll" ]
