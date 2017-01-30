# grip-docker

GitHub README.md Preview as Docker Image - [grip](https://github.com/joeyespo/grip)

## Build

```bash
make build
```

## Run


### Manually

```bash
docker run -it --rm -v $HOME/.grip:/root/.grip -v $PWD:/data:ro -p 6419:6419 menski/grip
```

### Script

Copy [`grip.sh`](grip.sh) somewhere in your path.
