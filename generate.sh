#!/bin/bash

#########################
#                       #
#    Config - Start     #
#                       #
#########################

author="" #Insert your name here
name="" #Insert the name of your site here
description="" #Insert a description of your site here
link="" #Link to your Yasbf instance for example: http://example.com/Yasbf
#echo "Y U NO RTFM?" & exit #RTFM protection just uncomment or remove this line if you have configured the lines above

#########################
#                       #
#     Config - End      #
#                       #
#########################

if [ "$(echo "$link" | sed -e "s/^.*\(.\)$/\1/")" = "/" ]; then
	link=$(echo "${link%?}")
fi

#Fill feed template with custom content
metafeed=$(awk '{sub(/\$name/,name);sub(/\$todayrss/,todayrss);sub(/\$description/,description);sub(/\$link/,link);}1' name="$name" todayrss="$(date -R)" description="$description" link="$link" templates/feed.xml)
#Fill header template with custom content
header=$(awk '{sub(/\$name/,name);sub(/\$description/,description);sub(/\$author/,author);sub(/\$linkcss/,linkcss);sub(/\$linkicon/,linkicon);sub(/\$linkarchives/,linkarchives);sub(/\$linkfeed/,linkfeed);sub(/\$linkindex/,linkindex);}1' name="$name" description="$description" author="$author" linkcss="$link/style.css" linkicon="$link/images/favicon.png" linkarchives="$link/archives.html" linkfeed="$link/feed.xml" linkindex="$link" templates/header.html)
#Fill footer template with custom content
footer=$(awk '{sub(/\$author/,author);sub(/\$year/,year);}1' author="$author" year="$(date +%Y)" templates/footer.html)

# Create archives folder (if it doesn't exist)
if [ ! -d "archives" ]; then
	mkdir archives
fi

#Sort the files in the folder 'posts' by a custom date which is specified in line 2 of every post
cd posts
for file in *
do
	customdate="$(sed -n 2p $file)"
	customdate="20${customdate:6:2}${customdate:0:2}${customdate:3:2}.${customdate:9:2}${customdate:12:2}"
	index="${index}${customdate},${file}\n"
done
#Generate ALL the files
for key in `echo -e ${index} | sort -r`
do

	#Some basic strings
	filename="$(echo "$key" | sed 's/.*,//')"
	postdate="$(sed -n 2p $filename | cut -d " " -f1)"
	postlink="/archives/$postdate/$filename"
	headline="<h1><a href="\".$postlink\"">$(sed -n 1p $filename)</a></h1>"
	h3="<h3>$postdate</h3>"
	article="$headline $h3 $(sed -n '4,$p' $filename)"
	
	#Generate the blog posts and the archive
	if [ ! -d "../archives/$postdate" ]; then
		mkdir "../archives/$postdate"
	fi
	archivesraw="<li><span>$postdate</span> » <a href="\".$postlink\"">$(sed -n 1p $filename)</a></li>"
	echo "$header <article>$article</article> $footer" > ../archives/$postdate/$filename
	echo $archivesraw >> ../archivesraw.html

	#Generate the index.html
	let indexcount=indexcount+1
	if [ $indexcount -le 5 ]; then
		echo $article >> ../article.html
	fi

	#Generate the rss feed
	let rsscount=rsscount+1
	if [ $rsscount -le 25 ]; then
		rssdate="$(sed -n 2p $filename)"
		rssdate="$(date -Rd "$(awk -F'[- ]' '{printf("20%s-%s-%s %s\n", $3,$1,$2,$4)}' <<<"$rssdate")")"
		itemfeed="<item><title>$(sed -n 1p $filename)</title><pubDate>$rssdate</pubDate><description><![CDATA[$(sed -n '4,$p' $filename)]]></description><link>$link$postlink</link><guid>$link$postlink</guid></item>"
		echo $itemfeed >> ../itemfeed.xml
	fi

done
cd ..

#Create index.html
article=$(cat article.html)
indexhtml="$header <article>$article</article> $footer"
echo $indexhtml > index.html

#Create feed.xml
itemfeed=$(cat itemfeed.xml)
feed="$metafeed $itemfeed </channel></rss>"
echo $feed > feed.xml

#Create archives.html
archives="$header <article><div id=\"archives\"><h1>Blog Archives</h1><ul>$(cat archivesraw.html)</ul></div></article> $footer"
echo $archives > archives.html

#Remove "workaround" files
rm archivesraw.html
rm article.html
rm itemfeed.xml
