#!/bin/bash
# Copyright (c) 2003-2014, CKSource - Frederico Knabben. All rights reserved.
# For licensing, see LICENSE.md or http://ckeditor.com/license

# Build CKEditor SDK

VERSION="offline"

if [ "$1" = "--version" ]
then
    VERSION=$2
fi

# Running builder excluding documentation
node app.js build $@

# Running documentation builder
if [ "$VERSION" = "offline" ]
then
    sh ../../docs/build.sh --config seo-off-config.json

    # Move generated documentation to proper directory
    mv ../../docs/build ../release/docs

    # Remove dynamically generated config
    rm ../../docs/seo-off-config.json

    node app.js fixdocs $@

    node app.js packbuild $@
fi