#!/bin/bash

#Print welcome message
echo "--"$(date +"%Y-%m-%d %T")"--"
echo "Yasbf has been started."

#Read configuration from the config.cfg file
echo "Reading configuration file..."
source config.cfg

#Remove end slash from the url/link (if it has one)
if [ $(echo $url | sed "s/^.*\(.\)$/\1/") == "/" ]; then
	url=$(echo $url | sed 's/\(.*\)./\1/')
fi

#Create archives folder (if it doesn't exist)
if [ ! -d "archives" ]; then
	mkdir archives
fi

#Fill feed template with custom content
feedtemplate=$(sed -e "s^{title}^$title^g" -e "s^{todayrss}^$(date -R)^g" -e "s^{description}^$description^g" -e "s^{url}^$url^g" -e "s^{author}^$author^g" -e "s^{itunes_explicit}^$itunes_explicit^g" -e "s^{itunes_owner_email}^$itunes_owner_email^g" -e "s^{itunes_category}^$itunes_category^g" -e "s^{language}^$language^g" -e "s^{author}^$author^g" -e "s^{itunes_image}^$itunes_image^g" -e "s^{year}^$(date +%Y)^g" templates/feed.rss)
#Fill header template with custom content
headertemplate=$(sed -e "s^{title}^$title^g" -e "s^{author}^$author^g" -e "s^{description}^$description^g" -e "s^{url}^$url^g" templates/header.html)
#Fill footer template with custom content
footertemplate=$(sed -e "s^{year}^$(date +%Y)^g" -e "s^{author}^$author^g" templates/footer.html)

#Sort the files in the folder 'posts' by a custom date which is specified in line 2 of every post
cd posts
for file in *.html
do
	customdate="$(sed -n 2p $file)"
	customdate="20${customdate:6:2}${customdate:0:2}${customdate:3:2}.${customdate:9:2}${customdate:12:2}"
	index="${index}${customdate},${file}\n"
done

#Generate ALL the posts
echo "Generating ALL the posts..."
for key in `echo -e ${index} | sort -r`
do
	#Some basic strings
	filename="$(echo "$key" | sed 's/.*,//')"
	postheadline="$(sed -n 1p $filename)"
	postdate="$(sed -n '2s/ .*//p' $filename)"
	enclosure_url="$(sed -n 3p $filename)"
	postcontent="$(sed -n '5,$p' $filename)"
	postlink="$url/archives/$postdate/$filename"
	if [ $flattr_id != "" ]
	then
		flattr_postheadline="$(echo "$postheadline" | sed 's/ /%20/g')"
		flattr_link="https://flattr.com/submit/auto?user_id=$flattr_id&url=$postlink&title=$flattr_postheadline&language=$flattr_lang&category=$flattr_category"
		flattr="<br/><a href=\"$flattr_link\"><img src=\"http://api.flattr.com/button/flattr-badge-large.png\" class=\"flattrbutton\" /></a>"
	fi
	if [ "$(echo $(sed -n 3p $filename) | cut -c 1-4)" == "http" ]; then
		article="<h1><a href=\"$postlink\">$postheadline</a></h1> <h3>$postdate</h3> $postcontent <audio controls=\"controls\"><source src="$enclosure_url" type="audio/mp3" /></audio> <br/> <a href=\"$enclosure_url\"><img src=\"$url/images/audio_mp3_button.png\"></a> $flattr"
	else
		article="<h1><a href=\"$postlink\">$postheadline</a></h1> <h3>$postdate</h3> $postcontent $flattr"
	fi
	
	#Generate the blog posts and the archive
	if [ ! -d "../archives/$postdate" ]; then
		mkdir "../archives/$postdate"
	fi
	echo "$headertemplate <article>$article</article> $footertemplate" > ../archives/$postdate/$filename
	archives="$archives <li><span>$postdate</span> » <a href=\"$postlink\">$postheadline</a></li>"

	#Generate the index.html
	let indexcount=indexcount+1
	if [ $indexcount -le $posts_on_blog_index ]; then
		indexhtml="$indexhtml $article"
	fi

	#Generate the rss feed
	let rsscount=rsscount+1
	if [ $rsscount -le $amount_of_rss_items ]; then
		rssdate="$(date -Rd "$(awk -F'[- ]' '{printf("20%s-%s-%s %s\n", $3,$1,$2,$4)}' <<< "$(sed -n 2p $filename)")")"
		#postcontent="$(echo $postcontent | sed -e 's/&/\&amp\;/g' -e 's/</\&lt\;/g' -e 's/>/\&gt\;/g' -e 's/"/\&quot\;/g' -e "s/'/\&#39\;/g")"
		flattr_link="$(echo $flattr_link | sed -e 's/&/\&amp\;/g' -e 's/</\&lt\;/g' -e 's/>/\&gt\;/g' -e 's/"/\&quot\;/g' -e "s/'/\&#39\;/g")"
		itunes_subtitle="$(echo $postcontent | cut -c 1-30 | sed 's/<[^>]*>//g')..."
		if [ "$(echo $(sed -n 3p $filename) | cut -c 1-4)" == "http" ]; then
			feed="$feed <item><title>$postheadline</title><itunes:author>$author</itunes:author><itunes:subtitle>$itunes_subtitle</itunes:subtitle><itunes:image href=\"$itunes_image\"/><pubDate>$rssdate</pubDate><description><![CDATA[$postcontent]]></description><guid>$postlink</guid><enclosure url=\"$enclosure_url\" length=\"0\" type=\"audio/mpeg\"/><atom:link rel=\"payment\" href=\"$flattr_link\" type=\"text/html\" /></item>"
		else
			feed="$feed <item><title>$postheadline</title><pubDate>$rssdate</pubDate><description><![CDATA[$postcontent]]></description><guid>$postlink</guid><link>$postlink</link><itunes:block>yes</itunes:block></item>"
		fi
	fi
done
cd ..

#Create index.html
echo "Creating blog index..."
indexhtml="$headertemplate <article>$indexhtml</article> $footertemplate"
echo $indexhtml > index.html

#Create feed.rss
echo "Creating rss feed..."
feed="$feedtemplate $feed </channel></rss>"
echo $feed > feed.rss

#Create archives.html
echo "Creating archives..."
archives="$headertemplate <article><div id=\"archives\"><h1>Blog Archives</h1><ul>$archives</ul></div></article> $footer"
echo $archives > archives.html

#Goodbye message
echo ""
echo "100%[======================================]"
echo "Blog generation was successful."
