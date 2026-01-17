# Images

Practical and advanced Docker CLI commands for inspecting, filtering, and cleaning Docker images.

---

## Listing and filtering images

### List dangling images

Dangling images are untagged images usually left after rebuilds.

```sh
docker images --filter "dangling=true"
```

---

### Filter images by repository or tag

```sh
docker images --filter "reference=myapp:*"
docker images --filter "reference=nginx:alpine"
```

---

### Get only image IDs (for scripting)

```sh
docker images --filter "dangling=true" -q
```

---

## Removing images

### Remove all dangling images

```sh
docker rmi $(docker images --filter "dangling=true" -q)
```

Script-safe variant:

```sh
docker images --filter "dangling=true" -q | xargs docker rmi
```

---

### Remove images by repository pattern

```sh
docker rmi $(docker images -q "myapp*")
```

---

## Image inspection and analysis

### Image history (layer inspection)

Shows how an image was built, layer by layer.

```sh
docker image history --no-trunc <image>
```

Useful for:
- finding large layers
- spotting accidental secrets
- understanding why an image is bloated

---

### Inspect image metadata

```sh
docker image inspect <image>
```

Get labels only:

```sh
docker image inspect -f '{{ json .Config.Labels }}' <image>
```

---

## Cleaning unused images safely

### Remove unused images older than a given time

```sh
docker image prune -a --filter "until=78h"
docker image prune -a --filter "until=4680m"
docker image prune -a --filter "until=2026-01-04T00:00:00"
```


Note:
`-a` removes **all unused images**, not only dangling ones!

---

### Remove images filtered by labels

```sh
docker image prune --filter "label=deprecated"
docker image prune --filter "label=maintainer=john"
docker image prune --filter "label!=maintainer"
```

Recommended pattern:
- label important images with `keep=true`
- prune everything else

```sh
docker image prune -a --filter "label!=keep"
```

---

## Disk usage and debugging

### Show image disk usage

```sh
docker system df -v
```

---

## Notes:

- Prefer label-based filtering over name matching.
- Avoid `docker image prune -a` without filters on shared machines.
- Regularly inspect image history in CI pipelines.
