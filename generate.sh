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

meta=$(awk '{sub(/\$name/,name);sub(/\$author/,author);sub(/\$description/,description);}1' name="$name" author="$author" description="$description" templates/meta.html)

header=$(awk '{sub(/\$name/,name);sub(/\$github/,github);sub(/\$description/,description);sub(/\$twitter/,twitter)}1' name="$name" github="$github" description="$description" twitter="$twitter" templates/header.html)

cd posts
for file in `ls --format=single-column *`; do
	placeholder="$(<"$file")"
	placeholder="<h1>${placeholder/$'\n'/</h1>$'\n'}";
	article="$article$placeholder"
done
cd ..

footer=$(awk '{sub(/\$author/,author);}1' author="$author" templates/footer.html)

html="$meta $header <article>$article</article> $footer"

if [ -f "index.html" ];
then
	rm index.html
fi

echo $html | tr '\r' ' ' >> index.html
