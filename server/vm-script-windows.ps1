Set-ExecutionPolicy Unrestricted

## Install Chocolatey
iwr https://chocolatey.org/install.ps1 -UseBasicParsing | iex
choco install git -y
choco install dotnetcore-sdk -y

mkdir C:\git
cd C:\git
git clone https://github.com/staff0rd/aspnetcore -b my_2.2_fork
cd /aspnetcore/src/SignalR/perf/benchmarkapps/BenchmarkServer
set ASPNETCORE_URLS=http://0.0.0.0
netsh advfirewall firewall add rule name="Open Port 80" dir=in action=allow protocol=TCP localport=80
dotnet run






















