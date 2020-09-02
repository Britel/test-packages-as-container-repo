# test-packages-as-container-repo

This is a test of whether creating multi-arch docker images works with Github Packages.

Status: ![Test Github Packages for Multi-Arch containers](https://github.com/bfjelds/test-packages-as-container-repo/workflows/Test%20Github%20Packages%20for%20Multi-Arch%20containers/badge.svg)

```bash
git clone https://github.com/bfjelds/test-packages-as-container-repo
cd test-packages-as-container-repo
make test
```

Currently test fails with this error message: `failed to put manifest ghcr.io/bfjelds/test:v0.1.0: manifest invalid`

See full output:

```bash
DOCKER_CLI_EXPERIMENTAL=enabled docker manifest create --amend ghcr.io/bfjelds/test:v0.1.0 ghcr.io/bfjelds/test:v0.1.0-amd64
Created manifest list ghcr.io/bfjelds/test:v0.1.0
DOCKER_CLI_EXPERIMENTAL=enabled docker manifest create --amend ghcr.io/bfjelds/test:v0.1.0 ghcr.io/bfjelds/test:v0.1.0-arm32v7
Created manifest list ghcr.io/bfjelds/test:v0.1.0
DOCKER_CLI_EXPERIMENTAL=enabled docker manifest create --amend ghcr.io/bfjelds/test:v0.1.0 ghcr.io/bfjelds/test:v0.1.0-arm64v8
Created manifest list ghcr.io/bfjelds/test:v0.1.0
DOCKER_CLI_EXPERIMENTAL=enabled docker manifest inspect ghcr.io/bfjelds/test:v0.1.0
{
   "schemaVersion": 2,
   "mediaType": "application/vnd.docker.distribution.manifest.list.v2+json",
   "manifests": [
      {
         "mediaType": "application/vnd.docker.distribution.manifest.v2+json",
         "size": 529,
         "digest": "sha256:e0a33348ac8cace6b4294885e6e0bb57ecdfe4b6e415f1a7f4c5da5fe3116e02",
         "platform": {
            "architecture": "amd64",
            "os": "linux"
         }
      },
      {
         "mediaType": "application/vnd.docker.distribution.manifest.v2+json",
         "size": 529,
         "digest": "sha256:6237fd8d18e2e2506ef73503f6d42ad1668eaf213f679ccce9d3f69bc6ca1d30",
         "platform": {
            "architecture": "arm",
            "os": "linux"
         }
      },
      {
         "mediaType": "application/vnd.docker.distribution.manifest.v2+json",
         "size": 529,
         "digest": "sha256:bd965c4e20c07cf623e8a3cf9122bf196db9872fb323ff1bbe1fabc838299f8f",
         "platform": {
            "architecture": "arm64",
            "os": "linux"
         }
      }
   ]
}
DOCKER_CLI_EXPERIMENTAL=enabled docker manifest push ghcr.io/bfjelds/test:v0.1.0
failed to put manifest ghcr.io/bfjelds/test:v0.1.0: manifest invalid
make: *** [test-docker-push-multi-arch-push] Error 1
Makefile:76: recipe for target 'test-docker-push-multi-arch-push' failed
```
