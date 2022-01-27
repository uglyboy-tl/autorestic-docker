Docker image based on the awesome [cupcakearmy/autorestic](https://github.com/cupcakearmy/autorestic).

## Install
1. Create an initial config file (`autorestic.yml`)
2. Create an empty file (`autorestic.lock.yml`)
3. run docker-compose as below:

``` yaml
version: "3"
services:
  autorestic:
    image: guixi/autorestic
    container_name: autorestic
    restart: unless-stopped
    volumes:
      - /etc/localtime:/etc/localtime:ro
      - $(pwd)/autorestic.yml:/root/.autorestic.yml:ro
      - $(pwd)/autorestic.lock.yml:/root/.autorestic.lock.yml
      - ~/.config/rclone/rclone.conf:/root/.config/rclone/rclone.conf:ro    #optional
      - my-volume:/data
```
## Usage
you can use autorestic directly such as
``` bash
docker exec -it autorestic autorestic exec -av -- snapshots
```

## License

[MIT](LICENSE) © Richard Littauer
