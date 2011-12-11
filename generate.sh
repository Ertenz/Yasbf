#!/bin/bash

#########################
#                       #
#    Config - Start     #
#                       #
#########################

author="" #Insert your name here
name="" #Insert the name of your site here
description="" #Insert a description of your site here
twitter="" #Insert your twitter username here
github="" #Insert your github username here
exit #RTFM protection just uncomment or remove this line if you configured the lines above

#########################
#                       #
#     Config - End      #
#                       #
#########################

year=$(date +%Y)

meta=$(awk '{sub(/\$name/,name);sub(/\$author/,author);sub(/\$description/,description);}1' name="$name" author="$author" description="$description" templates/meta.html)

header=$(awk '{sub(/\$name/,name);sub(/\$github/,github);sub(/\$description/,description);sub(/\$twitter/,twitter)}1' name="$name" github="$github" description="$description" twitter="$twitter" templates/header.html)

cd posts
for f in *
do
	headline="$(<"$f")"
	headline="<h1>${headline/$'\n'/</h1>$'\n'}";
	article="$article$headline"
done
cd ..

footer=$(awk '{sub(/\$author/,author);sub(/\$year/,year);}1' author="$author" year="$year" templates/footer.html)

html="$meta $header <article>$article</article> $footer"

if [ -f "index.html" ];
then
	rm index.html
fi

echo $html | tr '\r' ' ' >> index.html
