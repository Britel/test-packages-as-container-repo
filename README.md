# test-packages-as-container-repo

This is a test of whether creating multi-arch docker images works with Github Packages.

Status: ![Test Github Packages for Multi-Arch containers](https://github.com/bfjelds/test-packages-as-container-repo/workflows/Test%20Github%20Packages%20for%20Multi-Arch%20containers/badge.svg)

```bash
git clone https://github.com/bfjelds/test-packages-as-container-repo
cd test-packages-as-container-repo
make test
```

Currently test fails with this error message: `no such manifest: docker.pkg.github.com/bfjelds/test-packages-as-container-repo/test:v0.1.0-amd64`

See full output:

```bash
docker build  -f Dockerfile . -t docker.pkg.github.com/bfjelds/test-packages-as-container-repo/test:v0.1.0-amd64 --build-arg PLATFORM=amd64
Sending build context to Docker daemon  57.86kB
Step 1/2 : ARG PLATFORM=amd64
Step 2/2 : FROM ${PLATFORM}/debian:buster-slim
 ---> 4e22ed854b0a
Successfully built 4e22ed854b0a
Successfully tagged docker.pkg.github.com/bfjelds/test-packages-as-container-repo/test:v0.1.0-amd64
docker build  -f Dockerfile . -t docker.pkg.github.com/bfjelds/test-packages-as-container-repo/test:v0.1.0-arm32v7 --build-arg PLATFORM=arm32v7
Sending build context to Docker daemon  57.86kB
Step 1/2 : ARG PLATFORM=amd64
Step 2/2 : FROM ${PLATFORM}/debian:buster-slim
 ---> 1cada9546b9f
Successfully built 1cada9546b9f
Successfully tagged docker.pkg.github.com/bfjelds/test-packages-as-container-repo/test:v0.1.0-arm32v7
docker build  -f Dockerfile . -t docker.pkg.github.com/bfjelds/test-packages-as-container-repo/test:v0.1.0-arm64v8 --build-arg PLATFORM=arm64v8
Sending build context to Docker daemon  57.86kB
Step 1/2 : ARG PLATFORM=amd64
Step 2/2 : FROM ${PLATFORM}/debian:buster-slim
 ---> 3a7a67a31be0
Successfully built 3a7a67a31be0
Successfully tagged docker.pkg.github.com/bfjelds/test-packages-as-container-repo/test:v0.1.0-arm64v8
docker push docker.pkg.github.com/bfjelds/test-packages-as-container-repo/test:v0.1.0-amd64
The push refers to repository [docker.pkg.github.com/bfjelds/test-packages-as-container-repo/test]
b60e5c3bcef2: Layer already exists
v0.1.0-amd64: digest: sha256:8c6927676cde46c2ddd40c34f29d504f7dde3701f5e09e3723057bd25bfc87c7 size: 529
docker push docker.pkg.github.com/bfjelds/test-packages-as-container-repo/test:v0.1.0-arm32v7
The push refers to repository [docker.pkg.github.com/bfjelds/test-packages-as-container-repo/test]
8b73556c7c7d: Layer already exists
v0.1.0-arm32v7: digest: sha256:43e8691b4e25f4b0fd0f10bca8ea11b9f0578b0e5d2fe3b085290455dd07c0b6 size: 529
docker push docker.pkg.github.com/bfjelds/test-packages-as-container-repo/test:v0.1.0-arm64v8
The push refers to repository [docker.pkg.github.com/bfjelds/test-packages-as-container-repo/test]
16d216d72ff5: Layer already exists
v0.1.0-arm64v8: digest: sha256:9d2924f89b406cbb9ea45adba0d7b8cab9bb12dcb7f115d2d8589f0900e26d93 size: 529
DOCKER_CLI_EXPERIMENTAL=enabled docker manifest create --amend docker.pkg.github.com/bfjelds/test-packages-as-container-repo/test:v0.1.0 docker.pkg.github.com/bfjelds/test-packages-as-container-repo/test:v0.1.0-amd64
no such manifest: docker.pkg.github.com/bfjelds/test-packages-as-container-repo/test:v0.1.0-amd64
Makefile:61: recipe for target 'test-docker-multi-arch-create' failed
make: *** [test-docker-multi-arch-create] Error 1
```
