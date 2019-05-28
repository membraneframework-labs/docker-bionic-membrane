# Ubuntu 18.04 based Membrane Docker image

A docker image based on Ubuntu, with Erlang, Elixir and libraries necessary to test and run the [Membrane Framework](https://membraneframework.org).

This image is based on Ubuntu 18.04 (Bionic) and contains:
- Erlang 21.3
- Elixir 1.8.1
- FFmpeg 4.1.3
- SDL2
- FDK AAC 2.0

## Building the image
To rebuild the image, run the following command:

```sh
make build
```

Optionally, one can add the following variables:
* `VERSION=string`, which adds the version tag (for example, `1.1.1`). Set to `latest` by default.
* `IMAGE=name`, which will override the default image name. If not specified, this is set to `membrane/bionic-membrane`

## Sample usage

Execute the following command while being in you app's directory:

```sh
make run
```

or from anywhere:

```sh
DIR=/my/app/directory make run
```

This will start the container with the application directory mapped to `/app`. Inside the container, go to that directory:

```sh
cd /app
```

and execute your app's code (for example tests)
```sh
mix test
```

# Copyright and License

Copyright 2019, [Software Mansion](https://swmansion.com/?utm_source=git&utm_medium=readme&utm_campaign=docker-bionic-membrane)

[![Software Mansion](https://membraneframework.github.io/static/logo/swm_logo_readme.png)](https://swmansion.com/?utm_source=git&utm_medium=readme&utm_campaign=docker-bionic-membrane

Licensed under the [Apache License, Version 2.0](LICENSE)
