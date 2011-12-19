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
echo "RTFM" & exit #RTFM protection just uncomment or remove this line if you have configured the lines above

#########################
#                       #
#     Config - End      #
#                       #
#########################

year=$(date +%Y)
today=$(date)
linkcss="$link/style.css"

#Disclaimer: Everything below this line is absolutly dirty Code - You have been warned...

metafeed=$(awk '{sub(/\$name/,name);sub(/\$today/,today);sub(/\$description/,description);sub(/\$link/,link);}1' name="$name" today="$today" description="$description" link="$link" templates/feed.xml)

header=$(awk '{sub(/\$name/,name);sub(/\$github/,github);sub(/\$description/,description);sub(/\$twitter/,twitter);sub(/\$author/,author);sub(/\$linkcss/,linkcss);}1' name="$name" github="$github" description="$description" twitter="$twitter" author="$author" linkcss="$linkcss" templates/header.html)

footer=$(awk '{sub(/\$author/,author);sub(/\$year/,year);}1' author="$author" year="$year" templates/footer.html)

if [ -d "archives" ]; then
    rm -r archives
	mkdir archives
else
	mkdir archives
fi

cd posts
for file in *
do
	postlink="/archives/$(sed -n 2p $file)/$file"
	headline="<h1><a href="\".$postlink\"">$(sed -n 1p $file)</a></h1>"
	postdate="<h3>$(sed -n 2p $file)</h3>"
	article="$headline $postdate $(sed -n '4,$p' $file)"
	itemfeed="<item><title>$(sed -n 1p $file)</title><pubDate>$(sed -n 2p $file)</pubDate><description>$(sed -n '4,$p' $file)</description><link>$link$postlink</link></item>"
	mkdir "../archives/$(sed -n 2p $file)"
	archivesraw="<li><a href="\".$postlink\"">$(sed -n 2p $file) - $(sed -n 1p $file)</a></li>"
	echo "$header <article>$article</article> $footer" | tr '\r' ' ' >> "../archives/$(sed -n 2p $file)/$file"
	echo $article | tr '\r' ' ' >> ../article.html
	echo $itemfeed | tr '\r' ' ' >> ../itemfeed.xml
	echo $archivesraw | tr '\r' ' ' >> ../archivesraw.html
done
cd ..

article=$(cat article.html)

index="$header <article>$article</article> $footer"

if [ -f "index.html" ];
then
	rm index.html
fi

echo $index | tr '\r' ' ' >> index.html

if [ -f "feed.xml" ];
then
	rm feed.xml
fi

itemfeed=$(cat itemfeed.xml)
feed="$metafeed $itemfeed </channel></rss>"

echo $feed | tr '\r' ' ' >> feed.xml

if [ -f "archives.html" ];
then
	rm archives.html
fi

archives="$header <article><ul id="archives">$(cat archivesraw.html)</ul></article> $footer"
echo $archives | tr '\r' ' ' >> archives.html

rm archivesraw.html
rm article.html
rm itemfeed.xml
