REPO=menski
NAME=grip

TAG=latest
FROM=$(shell head -n1 Dockerfile | cut -d " " -f 2)
IMAGE=$(REPO)/$(NAME):$(TAG)
OPTS=--name=$(NAME) -v $(PWD):/data:ro -v $(HOME)/.grip:/root/.grip -p 6419:6419
LABEL=makefile-$(NAME)

.PHONY: build
build: rmf
	docker build --label $(LABEL) -t $(IMAGE) .

.PHONY: pull
pull: pull-from
	-docker pull $(IMAGE)

.PHONY: pull-from
pull-from:
	docker pull $(FROM)

.PHONY: push
push:
	docker push $(IMAGE)

.PHONY: rmf
rmf:
	-docker rm -f -v $(NAME)

.PHONY: run
run: build rmf
	docker run --rm -it --label $(LABEL) $(OPTS) $(IMAGE)

.PHONY: daemon
daemon: build rmf
	docker run -d $(OPTS) $(IMAGE)

.PHONY: shell
shell: rmf
	docker run -it $(OPTS) --entrypoint sh $(IMAGE)

.PHONY: exec
exec:
	docker exec -it -u root $(NAME) sh

.PHONY: logs
logs:
	docker logs $(NAME)

.PHONY: clean
clean: rmf
	-docker ps -a -q -f status=exited -f label=$(LABEL) | xargs -r -n 1 docker rm -f -v
	-docker images -q -f dangling=true -f label=$(LABEL) | xargs -r -n 1 docker rmi -f
