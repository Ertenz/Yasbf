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
link="" #Link to your Yasbf instance for example: http://example.com/Yasbf
echo "RTFM" & exit #RTFM protection just uncomment or remove this line if you configured the lines above

#########################
#                       #
#     Config - End      #
#                       #
#########################

year=$(date +%Y)
today=$(date)

metafeed=$(awk '{sub(/\$name/,name);sub(/\$today/,today);sub(/\$description/,description);sub(/\$link/,link);}1' name="$name" today="$today" description="$description" link="$link" templates/feed.xml)

header=$(awk '{sub(/\$name/,name);sub(/\$github/,github);sub(/\$description/,description);sub(/\$twitter/,twitter);sub(/\$author/,author);}1' name="$name" github="$github" description="$description" twitter="$twitter" author="$author" templates/header.html)

footer=$(awk '{sub(/\$author/,author);sub(/\$year/,year);}1' author="$author" year="$year" templates/footer.html)

cd posts
for file in *
do
	postlink=$(echo "$file" | sed 's/\(.*\)\..*/\1/')
	headline="<h1><a href="\"\#$postlink\"">$(sed -n 1p $file)</a></h1>"
	postdate="<h3>$(sed -n 2p $file)</h3>"
	article="$headline $postdate $(sed -n '4,$p' $file)"
	postfeed="<item><title>$(sed -n 1p $file)</title><pubDate>$(sed -n 2p $file)</pubDate><description>$(sed -n '4,$p' $file)</description><link>$link/#$postlink</link></item>"
	cd ..
	echo $article | tr '\r' ' ' >> article.html
	echo $postfeed | tr '\r' ' ' >> postfeed.xml
	cd posts
done
cd ..

article=$(cat article.html)

html="$header <article>$article</article> $footer"

if [ -f "index.html" ];
then
	rm index.html
fi

echo $html | tr '\r' ' ' >> index.html

if [ -f "feed.xml" ];
then
	rm feed.xml
fi

postfeed=$(cat postfeed.xml)
feed="$metafeed $postfeed </channel></rss>"

echo $feed | tr '\r' ' ' >> feed.xml
rm article.html
rm postfeed.xml
