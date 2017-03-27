# Docker Jobber

A minimal setup for running [Jobber](https://dshearer.github.io/jobber/) via [Supervisor](http://supervisord.org/) in a Docker container.

## Usage

    $ docker run -d --name my-docker-jobber -v $HOME/.jobber:/root/.jobber:ro richtr/docker-jobber

where `$HOME/.jobber` is the path to your [.jobber YAML file](https://dshearer.github.io/jobber/doc/v1.1/#/defining-jobs) on the Docker host machine.

To view the latest jobber activity on the running Docker container we can use `docker logs <CONTAINER>`:

    $ docker logs my-docker-jobber

## Docker Compose

You can use this project to create your own Docker Jobber images by creating a `Dockerfile` as follows:

``` yaml
FROM richtr/docker-jobber

# Copy the .jobber configuration to the server
ADD /my/.jobber /root/.jobber

# ...
```

### Feedback ###

If you find any bugs or issues please report them on the [Issue Tracker](https://github.com/richtr/docker-jobber/issues).

If you would like to contribute to this project please consider [forking this repo](https://github.com/richtr/docker-jobber/fork), making your changes and then creating a new [Pull Request](https://github.com/richtr/docker-jobber/pulls) back to the main code repository.
