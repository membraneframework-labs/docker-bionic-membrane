VERSION ?= latest
IMAGE ?= membrane/ubuntu-membrane-docker
DIR ?= `pwd`

build:
	docker build -t $(IMAGE):$(VERSION) .

run:
	docker run -it --rm -v $(DIR):/app $(IMAGE):$(VERSION) /bin/bash
