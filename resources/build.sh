#!/bin/bash

set -e
set -o pipefail

if [ ! -d "node_modules/.bin" ]; then
  echo "Be sure to run \`npm install\` before building GraphiQLWithExtensions."
  exit 1
fi

rm -rf dist/ && mkdir -p dist/
babel src --ignore __tests__ --out-dir dist/
echo "Bundling graphiqlWithExtensions.js..."
browserify -g browserify-shim -t browserify-css -s GraphiQLWithExtensions dist/index.js > graphiqlWithExtensions.js
echo "Bundling graphiqlWithExtensions.min.js..."
browserify -g browserify-shim -t browserify-css -t uglifyify -s GraphiQLWithExtensions dist/index.js | uglifyjs -c > graphiqlWithExtensions.min.js
# echo "Bundling graphiql.css..."
# postcss --no-map --use autoprefixer -d dist/ css/*.css
# cat dist/*.css > graphiql.css
echo "Done"
