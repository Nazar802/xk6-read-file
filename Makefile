MAKEFLAGS += --silent

all: clean build


## clean: Removes any previously created build artifacts.
clean:
	rm -f ./k6

## build: Builds a custom 'k6' with the local extension. 
build:
	go install go.k6.io/xk6/cmd/xk6@latest
	xk6 build --with $(shell go list -m)=.

## test: Executes any unit tests.
test:
	go test -cover -race ./...

.PHONY: build clean test
