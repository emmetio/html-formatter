#!/usr/bin/env bash

PATH=./node_modules/.bin:$PATH

convert () {
	local filename=$(basename "$1")
	local name="${filename%.*}"

	if [ $2 ]; then
		name=$2
	fi

	rollup -c -o dist/$name.cjs.js -f cjs $1
	rollup -c -o dist/$name.es.js -f es $1
}

# convert main file
convert "./index.js" "markup-formatters"

# convert formatters as stand-alone modules
for file in ./format/*
do
	if [ -f $file ]; then
		convert "$file"
	fi
done
