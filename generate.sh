#!/bin/bash

#########################
#                       #
#    Config - Start     #
#                       #
#########################

author="Me" #Insert your name here
name="test123" #Insert the name of your site here
description="This is just a test" #Insert a description of your site here
twitter="Poapfel" #Insert your twitter username here
github="Poapfel" #Insert your github username here

#########################
#                       #
#    Config - End       #
#                       #
#########################

meta=$(awk '{sub(/\$name/,name);sub(/\$author/,author);sub(/\$description/,description);}1' name="$name" author="$author" description="$description" templates/meta.html)

header=$(awk '{sub(/\$name/,name);sub(/\$github/,github);sub(/\$description/,description);sub(/\$twitter/,twitter)}1' name="$name" github="$github" description="$description" twitter="$twitter" templates/header.html)

article=

footer=

html="$meta $header"

if [ -f "index.html" ];
then
rm index.html
fi
echo $html | tr '\r' ' ' >> index.html
