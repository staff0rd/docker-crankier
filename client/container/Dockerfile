FROM mcr.microsoft.com/dotnet/core/sdk:2.2.105

RUN git clone https://github.com/staff0rd/aspnetcore -b my_2.2_fork

WORKDIR /aspnetcore/src/SignalR/perf/benchmarkapps/Crankier

RUN dotnet run

ENTRYPOINT [ "dotnet", "run", "local" ]
