Docker image based on the awesome [cupcakearmy/autorestic](https://github.com/cupcakearmy/autorestic).
## Features
Often it is usefully to trigger backups automatically. So in this image, it would be trigger the command every 5min.
## Install
1. Create an initial config file (`autorestic.yml`) such as:
``` yml
locations:
  my-location:
    from: /data
    to: my-backend
    cron: '0 3 * * 0' # Every Sunday at 3:00
```
  You can read full [docs](https://autorestic.vercel.app/config) to configure it.

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
      - ~/.config/rclone/rclone.conf:/root/.config/rclone/rclone.conf:ro  #optional
      - my-volume:/data
```
## Usage
you can use autorestic to show all buckups such as
``` bash
docker exec -it autorestic autorestic exec -av -- snapshots
```
and also use restic directly such as
``` bash
docker exec -it autorestic restic
```

## License

[MIT](LICENSE) © Uglyboy
