# Docker Jobber

A minimal setup for running [Jobber](https://dshearer.github.io/jobber/) via [Supervisor](http://supervisord.org/) in a Docker container.

## Usage

Pulling the images from [Dockerhub](https://hub.docker.com/):

    $ docker pull richtr/docker-jobber        # Ubuntu image
    $ docker pull richtr/docker-jobber:alpine # Alpine image

Jobber needs a `.jobber` file to schedule tasks to run. You can attach it as a volume with `docker run`.

``` bash
$ echo "---
- name: HelloWorld
  cmd: echo hello world
  time: 1
" >> .jobber
$ docker run --name my-docker-jobber -v $(pwd)/.jobber:/root/.jobber:ro richtr/docker-jobber
```

To view the latest jobber activity on the running Docker container we can use `docker logs <CONTAINER>`:

    $ docker logs my-docker-jobber

## Docker Compose

The `richtr/docker-jobber` and `richtr/docker-jobber:alpine` images simplify the process by adding an ONBUILD task to copy a configuration file called `.jobber` in the same directory as the `Dockerfile`.

You can use this project to create your own images by adding a `.jobber` file to the same directory as your `docker-compose.yml` file and simply using `FROM richtr/docker-jobber` or `FROM richtr/docker-jobber:alpine`.

``` yaml
FROM richtr/docker-jobber

# ...
```

### Feedback ###

If you find any bugs or issues please report them on the [Issue Tracker](https://github.com/richtr/docker-jobber/issues).

If you would like to contribute to this project please consider [forking this repo](https://github.com/richtr/docker-jobber/fork), making your changes and then creating a new [Pull Request](https://github.com/richtr/docker-jobber/pulls) back to the main code repository.
