V ?= 0

SRC_DIR = src
TEST_DIR = spec
BUILD_DIR = build

PREFIX = .
DIST_DIR = ${PREFIX}/dist

JS_ENGINE ?= `which node nodejs`
COMPILER = ${JS_ENGINE} ${BUILD_DIR}/uglify.js --unsafe

BASE_FILES = ${SRC_DIR}/custom_widget.js

MODULES = ${SRC_DIR}/intro.js\
	${BASE_FILES}\
	${SRC_DIR}/outro.js

JQ = ${DIST_DIR}/custom-widget.js
JQ_MIN = ${DIST_DIR}/custom-widget.min.js

JQ_VER = $(shell cat version.txt)
VER = sed "s/@VERSION/${JQ_VER}/"

DATE=$(shell git log -1 --pretty=format:%ad)

all: jquery min lint
	@@echo "Custom widget build complete."

${DIST_DIR}:
	@@mkdir -p ${DIST_DIR}

ifeq ($(strip $(V)),0)
verbose = --quiet
else ifeq ($(strip $(V)),1)
verbose =
else
verbose = --verbose
endif

jquery: ${JQ}
jq: ${JQ}

${JQ}: ${MODULES} | ${DIST_DIR}
	@@echo "Building" ${JQ}

	@@cat ${MODULES} | \
		sed 's/.function..jQuery...{//' | \
		sed 's/}...jQuery..;//' | \
		sed 's/@DATE/'"${DATE}"'/' | \
		${VER} > ${JQ};

lint: jquery
	@@if test ! -z ${JS_ENGINE}; then \
		echo "Checking against JSLint..."; \
		${JS_ENGINE} build/jslint-check.js; \
	else \
		echo "You must have NodeJS installed in order to test against JSLint."; \
	fi

min: ${JQ_MIN}

${JQ_MIN}: jquery
	@@if test ! -z ${JS_ENGINE}; then \
		echo "Minifying" ${JQ_MIN}; \
		${COMPILER} ${JQ} > ${JQ_MIN}.tmp; \
		sed '$ s#^\( \*/\)\(.\+\)#\1\n\2;#' ${JQ_MIN}.tmp > ${JQ_MIN}; \
		rm -rf ${JQ_MIN}.tmp; \
	else \
		echo "You must have NodeJS installed in order to minify."; \
	fi

test:
	phantomjs spec/run_jasmine.js http://localhost:2000/spec/SpecRunner.html 2> /dev/null

test-hudson:
	phantomjs spec/run_jasmine_for_hudson.js http://localhost:2000/spec/SpecRunner.html 2> /dev/null

test-browser:
	google-chrome http://localhost:2000/spec/SpecRunner.html

clean:
	@@echo "Removing Distribution directory:" ${DIST_DIR}
	@@rm -rf ${DIST_DIR}

.PHONY: all jquery lint min init jq clean
