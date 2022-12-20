# PHPStorm

## Build
Via GitHub repository
```bash
$ docker build --tag alireaza/phpstorm:$(date -u +%Y%m%d) --tag alireaza/phpstorm:latest https://github.com/alireaza/phpstorm.git
```

## Run
```bash
$ docker run \
--interactive \
--tty \
--rm \
--mount="type=bind,source=/tmp/.X11-unix,target=/tmp/.X11-unix" \
--env="DISPLAY=$DISPLAY" \
--device="/dev/dri:/dev/dri" \
--env="TZ=$(cat /etc/timezone)" \
--mount="type=bind,source=$(pwd)/udocker,target=/home/udocker" \
--name="phpstorm" \
alireaza/phpstorm
```

