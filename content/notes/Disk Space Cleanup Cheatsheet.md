## Git

```bash
# Remove garbage from interrupted operations
rm .git/objects/pack/tmp_pack_*

# Garbage collect and prune
git gc --prune=now

# Check space usage
git count-objects -vH
```

## Sorbet (Ruby)

```bash
# Delete cache (regenerates on next srb run)
rm -rf sorbet/.cache
```

## Go Modules

```bash
# Clear entire module cache
go clean -modcache

# Or just VCS cache
rm -rf ~/go/pkg/mod/cache/vcs
```

## Bazel

```bash
# Clean with expunge
bazel clean --expunge

# Or delete directly
rm -rf ~/.cache/bazel
```

## Docker

```sh
docker volume prune --all
```

## Bento Remote

```sh
isc login aws
bento remote resize-volume 1000
bento remote reboot
```
