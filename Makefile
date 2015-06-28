.PHONY: build
build:
	packer build build.json

.PHONY: debug
debug:
	packer build -debug build.json
