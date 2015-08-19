.PHONY: build
build:
	DIGITAL_OCEAN_API_TOKEN=$${DIGITAL_OCEAN_API_TOKEN:?} packer build build.json

.PHONY: debug
debug:
	packer build -debug build.json
