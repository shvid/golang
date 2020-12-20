#
#   Simple makefile for golang project
#
#   Alex Shvid
#
#

GO_VER := 1.14.6
IMAGE = golang
VERSION := $(shell git describe --tags --always --dirty)
REGISTRY = shvid
TAG := $(VERSION)
PWD := $(shell pwd)

all: build

version:
	@echo $(TAG)

build:
	docker build -t $(REGISTRY)/$(IMAGE):$(TAG) --build-arg GO_VER=$(GO_VER) -f Dockerfile .

run: build
	docker run -it --rm $(REGISTRY)/$(IMAGE):$(TAG) go version

dump: build
	docker save $(REGISTRY)/$(IMAGE):$(TAG) | gzip > $(IMAGE).tar.gz

push: build
	docker push ${REGISTRY}/${IMAGE}:${TAG}

login:
	docker login docker.io

clean:
	docker ps -q -f 'status=exited' | xargs docker rm
	docker image list | grep \\-dirty | awk -F' ' '{print $3}' | xargs docker image rm
	echo "y" | docker system prune -a
