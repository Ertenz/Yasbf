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
link="" #Link to your Yasbf instance WITHOUT AN END SLASH!
echo "Y U NO RTFM?" & exit #RTFM protection just uncomment or remove this line if you have configured the lines above

#########################
#                       #
#     Config - End      #
#                       #
#########################

#Disclaimer: Everything below this line has to be rewritten, I will do this soon...

todayrss="$(date -R)"

metafeed=$(awk '{sub(/\$name/,name);sub(/\$todayrss/,todayrss);sub(/\$description/,description);sub(/\$link/,link);}1' name="$name" todayrss="$todayrss" description="$description" link="$link" templates/feed.xml)

header=$(awk '{sub(/\$name/,name);sub(/\$github/,github);sub(/\$description/,description);sub(/\$twitter/,twitter);sub(/\$author/,author);sub(/\$linkcss/,linkcss);sub(/\$linkicon/,linkicon);sub(/\$linkarchives/,linkarchives);sub(/\$linkfeed/,linkfeed);}1' name="$name" github="$github" description="$description" twitter="$twitter" author="$author" linkcss="$link/style.css" linkicon="$link/images/favicon.png" linkarchives="$link/archives.html" linkfeed="$link/feed.xml" templates/header.html)

footer=$(awk '{sub(/\$author/,author);sub(/\$year/,year);}1' author="$author" year="$(date +%Y)" templates/footer.html)

if [ -d "archives" ]; then
	rm -r archives
	mkdir archives
else
	mkdir archives
fi

cd posts
index=""
for file in *
do
	customdate="$(sed -n 2p $file)"
	customdate="20${customdate:6:2}${customdate:0:2}${customdate:3:2}.${customdate:9:2}${customdate:12:2}"
	index="${index}${customdate},${file}\n"
done

#This loop generates the archive.html
for key in `echo -e ${index} | sort -r`
do
	filename="$(echo "$key" | sed 's/.*,//')"
	postdate="$(sed -n 2p $filename | cut -d " " -f1)"
	postlink="/archives/$postdate/$filename"
	if [ ! -d "../archives/$postdate" ]; then
		mkdir "../archives/$postdate"
	fi
	archivesraw="<li><a href="\".$postlink\"">$postdate - $(sed -n 1p $filename)</a></li>"
	echo "$header <article>$article</article> $footer" | tr '\r' ' ' >> "../archives/$postdate/$filename"
	echo $archivesraw | tr '\r' ' ' >> ../archivesraw.html
done

#This loop generates the index.html
for key in `echo -e ${index} | sort -r`
do
	filename="$(echo "$key" | sed 's/.*,//')"
	postdate="$(sed -n 2p $filename | cut -d " " -f1)"
	postlink="/archives/$postdate/$filename"
	headline="<h1><a href="\".$postlink\"">$(sed -n 1p $filename)</a></h1>"
	h3="<h3>$postdate</h3>"
	article="$headline $h3 $(sed -n '4,$p' $filename)"
	echo $article | tr '\r' ' ' >> ../article.html
	test $((++loop1)) -ge 5 && break
done

#This loop generates the rss feed
for key in `echo -e ${index} | sort -r`
do
	filename="$(echo "$key" | sed 's/.*,//')"
	postdate="$(sed -n 2p $filename | cut -d " " -f1)"
	postlink="/archives/$postdate/$filename"
	rssdate="$(sed -n 2p $filename)"
	rssdate="$(date -Rd "$(awk -F'[- ]' '{printf("20%s-%s-%s %s\n", $3,$1,$2,$4)}' <<<"$rssdate")")"
	itemfeed="<item><title>$(sed -n 1p $filename)</title><pubDate>$rssdate</pubDate><description><![CDATA[$(sed -n '4,$p' $filename)]]></description><link>$link$postlink</link><guid>$link$postlink</guid></item>"
	echo $itemfeed | tr '\r' ' ' >> ../itemfeed.xml
	test $((++loop2)) -ge 15 && break
done
#Yeah I know it's stupid to split this up into three loops because it's possible to do it with one loop <- very first item on to do list
cd ..

article=$(cat article.html)

indexhtml="$header <article>$article</article> $footer"

if [ -f "index.html" ];
then
	rm index.html
fi

echo $indexhtml | tr '\r' ' ' >> index.html

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
