.PHONY: ci
ci: lint style build test cov-cli codecov doc

.DEFAULT_GOAL := commit
.PHONY: commit
commit: style lint build test cov-cli cov-html doc

.PHONY: codecov
codecov: test
	yarn codecov -f coverage/*.json

.PHONY: cov-html
cov-html: test
	yarn nyc report --reporter=html

.PHONY: cov-cli
cov-cli: test
	yarn nyc report

.PHONY: test
test: build
	yarn nyc --reporter=json mocha --require source-map-support/register --ui tdd --use_strict dist/test/**/*.test.js

.PHONY: build
build: transpile

.PHONY: transpile
transpile:
	yarn tsc

.PHONY: format
format:
	yarn prettier --write ./lib ./test

.PHONY: style
style:
	yarn prettier --check ./lib ./test

.PHONY: lint
lint:
	yarn eslint . --ext .ts --fix

.PHONY: doc
doc:
	yarn typedoc ./lib/index.ts --out ./dist/doc --json ./dist/doc/doc.json --theme minimal --name "Hello World!" --includeVersion
