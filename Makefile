

all: clean lint | build

# -----------------------------------------------------------------------------
# Prerequisites
# -----------------------------------------------------------------------------

# Install dependencies
node_modules:
	npm install

# -----------------------------------------------------------------------------
# Targets
# -----------------------------------------------------------------------------

# Build theme for distribution with Webpack
material: $(shell find src) .babelrc webpack.config.js
	$(shell npm bin)/webpack --mode production

# -----------------------------------------------------------------------------
# Rules
# -----------------------------------------------------------------------------

# Build distribution files
build: node_modules material

# Clean distribution files
clean:
	rm -rf material

# Lint source files
lint: node_modules
	$(shell npm bin)/eslint --max-warnings 0 .
	$(shell npm bin)/stylelint `find src/assets -name *.scss`

# Rebuild theme on changes with Webpack
watch-webpack: node_modules clean
	$(shell npm bin)/webpack --watch

# Serve documentation with MkDocs
watch-mkdocs: clean
	while [ ! -d "./material" ]; do sleep 1; done
	mkdocs serve

# Run Webpack and MkDocs in watch mode
watch: node_modules watch-webpack watch-mkdocs

# -----------------------------------------------------------------------------

# Special targets
.PHONY: .FORCE build clean lint watch watch-mkdocs watch-webpack
.FORCE:
