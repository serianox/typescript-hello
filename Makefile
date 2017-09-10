.PHONY: ci
ci: lint build test cov-cli codecov

.PHONY: commit
commit: lint build test cov-cli cov-html doc

.PHONY: codecov
codecov: cov-cli
	codecov -f coverage/*.json

.PHONY: cov-html
cov-html: test
	nyc report --reporter=html

.PHONY: cov-cli
cov-cli: test
	nyc report

.PHONY: test
test: build
	nyc --reporter=json mocha dist/test --ui tdd

.PHONY: build
build: transpile

.PHONY: transpile
transpile:
	tsc

.PHONY: lint
lint:
	tslint -c tslint.json -p tsconfig.json

.PHONY: doc
doc:
	typedoc --out ./doc --json ./doc/doc.json --theme default --module commonjs
