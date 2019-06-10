# docker-crankier
Load testing ASP.NET Core SignalR with docker

Available on dockerhub via [staff0rd/crankier](https://hub.docker.com/r/staff0rd/crankier).

## Usage (client)

The image uses an entrypoint of `dotnet run local` so all additional parameters will be passed to crankier:

`docker run staff0rd/crankier --target-url http://yourDomain/yourHub --workers 10`

Or run on azure containers:

`az container create -g crankier --image staff0rd/crankier --cpu 1 --memory 1 --command-line "dotnet run local --target-url http://myVmBro.westus2.cloudapp.azure.com/echo --workers 10 --connections 20000" --no-wait --name myContainer`

## Usage (server)

Run a server that the client(s) will connect to:

```
docker run -d -p 80:80 --name crankier staff0rd/crankier-server
```