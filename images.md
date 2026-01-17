# Images

Practical Docker CLI commands for working with multiple images.

---

##
```sh
docker images --filter "dangling=true"
docker images --filter "repository=sometag"
```

```sh
docker rmi $(docker images --filter "dangling=true" -q)
```

## 
Image hostory
```sh
docker image history --no-trunc <image>
```

## Cleaning dangling images

Delete dangling images created before certain point in the time:
```sh
docker image prune -a --filter "until=78h"
docker image prune -a --filter "until=4680m"
docker image prune -a --filter "until=2026-01-04T00:00:00"
```

Delete dangling images filterd by labels:
```sh
docker image prune --filter="label=deprecated"
docker image prune --filter="label=maintainer=john"
docker image prune --filter="label!=maintainer"
```
