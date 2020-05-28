#!/bin/bash

FF='01_intro 02_GLM'



FF=`find . -maxdepth 2 -mindepth 2 -type f -regextype grep \
     -not -regex "^\./template/.*" \
     -iname index.org \
    | sed 's|\./||' | sed 's|/index.org||'`
