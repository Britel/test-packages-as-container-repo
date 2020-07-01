BUILD_AMD64 ?= 1
BUILD_ARM32 ?= 1
BUILD_ARM64 ?= 1

PREFIX ?= docker.pkg.github.com/bfjelds/test-packages-as-container-repo
LABEL_PREFIX ?= v0.1.0

CACHE_OPTION ?=

ENABLE_DOCKER_MANIFEST = DOCKER_CLI_EXPERIMENTAL=enabled

AMD64_SUFFIX = amd64
ARM32V7_SUFFIX = arm32v7
ARM64V8_SUFFIX = arm64v8


#
#
# TEST: make and push the images for test:
#
#    To make all platforms: `make test`
#    To make specific platforms: `BUILD_AMD64=1 BUILD_ARM32=0 BUILD_ARM64=1 make test`
#
#
.PHONY: test
test: test-docker-build test-docker-push-per-arch test-docker-push-multi-arch-create test-docker-push-multi-arch-push

test-docker-build: test-build-amd64 test-build-arm32 test-build-arm64
test-build-amd64:
ifeq (1, ${BUILD_AMD64})
	docker build $(CACHE_OPTION) -f Dockerfile . -t $(PREFIX)/test:$(LABEL_PREFIX)-$(AMD64_SUFFIX) --build-arg PLATFORM=$(AMD64_SUFFIX)
endif
test-build-arm32:
ifeq (1, ${BUILD_ARM32})
	docker build $(CACHE_OPTION) -f Dockerfile . -t $(PREFIX)/test:$(LABEL_PREFIX)-$(ARM32V7_SUFFIX) --build-arg PLATFORM=$(ARM32V7_SUFFIX)
endif
test-build-arm64:
ifeq (1, ${BUILD_ARM64})
	docker build $(CACHE_OPTION) -f Dockerfile . -t $(PREFIX)/test:$(LABEL_PREFIX)-$(ARM64V8_SUFFIX) --build-arg PLATFORM=$(ARM64V8_SUFFIX)
endif


test-docker-push-per-arch: test-docker-per-arch-amd64 test-docker-per-arch-arm32 test-docker-per-arch-arm64
test-docker-per-arch-amd64:
ifeq (1, ${BUILD_AMD64})
	docker push $(PREFIX)/test:$(LABEL_PREFIX)-$(AMD64_SUFFIX)
endif
test-docker-per-arch-arm32:
ifeq (1, ${BUILD_ARM32})
	docker push $(PREFIX)/test:$(LABEL_PREFIX)-$(ARM32V7_SUFFIX)
endif
test-docker-per-arch-arm64:
ifeq (1, ${BUILD_ARM64})
	docker push $(PREFIX)/test:$(LABEL_PREFIX)-$(ARM64V8_SUFFIX)
endif


test-docker-push-multi-arch-create: test-docker-multi-arch-create
test-docker-multi-arch-create:
ifeq (1, ${BUILD_AMD64})
	$(ENABLE_DOCKER_MANIFEST) docker manifest create --amend $(PREFIX)/test:$(LABEL_PREFIX) $(PREFIX)/test:$(LABEL_PREFIX)-$(AMD64_SUFFIX)
endif
ifeq (1, ${BUILD_ARM32})
	$(ENABLE_DOCKER_MANIFEST) docker manifest create --amend $(PREFIX)/test:$(LABEL_PREFIX) $(PREFIX)/test:$(LABEL_PREFIX)-$(ARM32V7_SUFFIX)
endif
ifeq (1, ${BUILD_ARM64})
	$(ENABLE_DOCKER_MANIFEST) docker manifest create --amend $(PREFIX)/test:$(LABEL_PREFIX) $(PREFIX)/test:$(LABEL_PREFIX)-$(ARM64V8_SUFFIX)
endif


test-docker-push-multi-arch-push:
	$(ENABLE_DOCKER_MANIFEST) docker manifest push $(PREFIX)/test:$(LABEL_PREFIX)
