# Containers

Practical Docker CLI commands for working with multiple containers and inspecting container metadata.

---

## Handling multiple containers

### List all containers with name containing `myapp`

```sh
docker container ls -a --filter "name=myapp"
```

### Remove all containers with name containing "myapp"
```sh
docker rm $(docker container ls -qa --filter "name=myapp")
# or 
docker container ls -qa --filter "name=myapp" | xargs docker rm
# to force remove also running containers:
docker container ls -qa --filter "name=myapp" | xargs docker rm -f
```

---

## Getting container metadata

### Get container network name(s) and IP address(es)
```sh
docker inspect -f '{{ range $name, $net := .NetworkSettings.Networks }}{{ $name }}: {{ $net.IPAddress }}{{ "\n" }}{{ end }}' <container>
```

### Get container exposed ports
```sh
docker inspect -f '{{ json .NetworkSettings.Ports }}' <container>
```

## Get container environment variables
```sh
docker inspect -f '{{ range .Config.Env }}{{ . }}{{ "\n" }}{{ end }}' <container>
```

## Get container mounts (volumes and bind mounts)
```sh
docker inspect -f '{{ range .Mounts }}{{ .Source }} -> {{ .Destination }}{{ "\n" }}{{ end }}' <container>
```

---
