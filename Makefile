projectID=tekwrks
repo=quackup
name=renderer
version=1.0.0

.PHONY:build
build:
	docker image build \
		-t ${repo}/${name}:${version} \
		.

.PHONY:run
run:
	docker container run \
		-d \
		--name ${repo}-${name}-dev \
		-p 3000:3000 \
		--env-file .env \
		-t ${repo}/${name}:${version}

.PHONY:kill
kill:
	docker rm $$( \
	docker kill $$( \
	docker ps -aq \
	--filter="name=${repo}-${name}-dev" ))

.PHONY: push
push:
	set -ex;
	docker tag \
		${repo}/${name}:${version} \
		gcr.io/${projectID}/${name}:${version}
	docker push \
		gcr.io/${projectID}/${name}:${version}

