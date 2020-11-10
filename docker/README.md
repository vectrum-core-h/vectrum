# Run in docker
Simple and fast setup of **VECTRUM** on Docker is also available.

## Install Dependencies
- [Docker](https://docs.docker.com) Docker 17.05 or higher is required
- [docker-compose](https://docs.docker.com/compose/) version >= 1.10.0

## Docker Requirement
- At least 7GB RAM (Docker -> Preferences -> Advanced -> Memory -> 7GB or above)
- If the build below fails, make sure you've adjusted Docker Memory settings and try again.

## Build, Push and Remove local images
Edit `VERSION` in `.environment` file.
```bash
./bpr.sh
```

## Build vectrum image
```bash
git clone https://github.com/vectrum-core/vectrum.git --recursive  --depth 1
cd vectrum/docker
docker build \
  --no-cache \
  --tag vectrum/vectrum \
  .
```

The above will build off the most recent commit to the master branch by default. If you would like to target a specific `branch/tag`, you may use a build argument. For example, if you wished to generate a docker image based off of the `v1.0.0` tag, you could do the following:
```bash
docker build \
  --no-cache \
  --tag vectrum/vectrum:v0.1.0 \
  --build-arg branch=v0.1.0 \
  .
```


By default, the symbol in `eosio.system` is set to `VTM`. You can override this using the `symbol` argument while building the docker image.
```bash
docker build \
  --no-cache \
  --tag vectrum/vectrum \
  --build-arg symbol=<symbol> \
  .
```

## Start vectrum-node docker container only
```bash
docker run \
  --name vectrum_node \
  --publish 8888:8888 --publish 9876:9876 \
  --tag vectrum/vectrum \
  vectrum-node.sh \
    -e -p eosio \
    --http-alias=vectrum_node:8888 \
    --http-alias=127.0.0.1:8888 \
    --http-alias=localhost:8888 \
    arg1 arg2
```

By default, all data is persisted in a docker volume. It can be deleted if the data is outdated or corrupted:
```bash
docker inspect --format '{{ range .Mounts }}{{ .Name }} {{ end }}' vectrum_node
fdc265730a4f697346fa8b078c176e315b959e79365fc9cbd11f090ea0cb5cbc
docker volume rm fdc265730a4f697346fa8b078c176e315b959e79365fc9cbd11f090ea0cb5cbc
```

Alternately, you can directly mount host directory into the container
```bash
docker run \
  --name vectrum_node \
  --publish 8888:8888 --publish 9876:9876 \
  --tag vectrum/vectrum \
  --volume /path-to-data-dir:/data \
  vectrum-node.sh \
    -e -p eosio \
    --http-alias=vectrum_node:8888 \
    --http-alias=127.0.0.1:8888 \
    --http-alias=localhost:8888 \
    arg1 arg2
```

## Get chain info
```bash
curl http://127.0.0.1:8888/v1/chain/get_info
```

## Start both vectrum_node and vectrum_wallet containers
```bash
docker volume create --name=vectrum-node-data-volume
docker volume create --name=vectrum-wallet-data-volume
docker-compose up -d
```

After `docker-compose up -d`, two services named `vectrum-node` and `vectrum-wallet` will be started. `vectrum_node` service would expose ports `8888` and `9876` to the host. `vectrum_wallet` service does not expose any port to the host, it is only accessible to `vectrum-cli` when running `vectrum-cli` is running inside the `vectrum_wallet` container as described in "Execute vectrum-cli commands" section.

### Execute vectrum-cli commands
You can run the `vectrum-cli` commands via a bash alias.
```bash
alias vectrum-cli='docker-compose exec vectrum_wallet /opt/vectrum/bin/vectrum-cli -u http://vectrum_node:8888 --wallet-url http://localhost:8900'
vectrum-cli get info
vectrum-cli get account inita
```

Upload sample example contract:
```bash
vectrum-cli set contract example contracts/example/
```

If you don't need `vectrum_wallet` afterwards, you can stop the `vectrum_wallet` service using
```bash
docker-compose stop vectrum_wallet
```

### Develop/Build custom contracts
Due to the fact that the `vectrum/vectrum` image does not contain the required dependencies for contract development (this is by design, to keep the image size small), you will need to utilize the `vectrum/vectrum-dev` image. This image contains both the required binaries and dependencies to build contracts using `vectrum-cpp`.

You can either use the image available on [Docker Hub](https://hub.docker.com/r/vectrum/vectrum-dev/) or navigate into the dev folder and build the image manually.
```bash
cd dev
docker build \
  --no-cache \
  --tag vectrum/vectrum-dev \
  .
```

### Change default configuration
You can use docker compose override file to change the default configurations. For example, create an alternate config file `config2.ini` and a `docker-compose.override.yml` with the following content.
```yml
version: "3"

services:
  vectrum_node:
    volumes:
      - vectrum-node-data-volume:/data
      - ./config2.ini:/data/config.ini
```

Then restart your docker containers as follows:
```bash
docker-compose down
docker-compose up
```

### Clear data dir
The data volume created by docker-compose can be deleted as follows:
```bash
docker volume rm vectrum-node-data-volume
docker volume rm vectrum-wallet-data-volume
```

### Docker Hub
Docker Hub images are now deprecated. New build images were discontinued on January 1st, 2019. The existing old images will be removed on June 1st, 2019.

### VECTRUM Testnet
We can easily set up a VECTRUM local testnet using docker images. Just run the following commands:

Note: if you want to use the mongo db plugin, you have to enable it in your `/data/config.ini` first.
```bash
# create volume
docker volume create --name=vectrum-node-data-volume
docker volume create --name=vectrum-wallet-data-volume
# pull images and start containers
docker-compose --file docker-compose-vectrum-latest.yml up -d
# get chain info
curl http://127.0.0.1:8888/v1/chain/get_info
# get logs
docker-compose logs --file vectrum-node
# stop containers
docker-compose --file docker-compose-vectrum-latest.yml down
```

The `blocks` data are stored under `--data-dir` by default, and the wallet files are stored under `--wallet-dir` by default, of course you can change these as you want.

### About MongoDB Plugin
Currently, the mongodb plugin is disabled in `config.ini` by default, you have to change it manually in `config.ini` or you can mount a `config.ini` file to `/data/config.ini` in the docker-compose file.
