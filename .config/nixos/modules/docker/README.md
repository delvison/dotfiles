- docker-compose files are kept in ./src
- convert compose yaml to nix code via [`compose2nix`](https://github.com/aksiksi/compose2nix)

```
$ nix run github:aksiksi/compose2nix -- --inputs ./src/docker-compose.yml --project {{project_name}} --runtime docker
```
