VERSION ?= latest
IMAGE ?= membrane/docker-ubuntu18-membrane
DIR ?= `pwd`

build:
	docker build -t $(IMAGE):$(VERSION) .

run:
	docker run -it --rm -v $(DIR):/app $(IMAGE):$(VERSION) /bin/bash
