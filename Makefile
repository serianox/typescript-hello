.PHONY: ci
ci: lint style build test cov-cli codecov doc

.DEFAULT_GOAL := commit
.PHONY: commit
commit: lint build test cov-cli cov-html doc

.PHONY: codecov
codecov: test
	npx codecov -f coverage/*.json

.PHONY: cov-html
cov-html: test
	npx nyc report --reporter=html

.PHONY: cov-cli
cov-cli: test
	npx nyc report

.PHONY: test
test: build
	npx nyc --reporter=json mocha --require source-map-support/register --ui tdd --use_strict dist/test/**/*.test.js || true

.PHONY: build
build: transpile

.PHONY: transpile
transpile:
	npx tsc

.PHONY: fmt
fmt:
	npx tsfmt --replace

.PHONY: style
style:
	npx tsfmt --verify || true

.PHONY: lint
lint:
	npx tslint -c tslint.json -p tsconfig.json || true

.PHONY: doc
doc:
	npx typedoc --out ./doc --json ./doc/doc.json --theme default --module commonjs
