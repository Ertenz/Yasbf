# Yasbf #

A very dirty static blogging framework.

Install
--------

### Getting the source: ######

	$ git clone git://github.com/Poapfel/Yasbf.git

### Basic configuration: ######

	$ cd Yasbf

Open the file [generate.sh](https://github.com/Poapfel/Yasbf/blob/master/generate.sh) with your favorite editor and fill in the informations form line [9](https://github.com/Poapfel/Yasbf/blob/master/generate.sh#L9) to [14](https://github.com/Poapfel/Yasbf/blob/master/generate.sh#L14). Then uncomment or delete the line [15](https://github.com/Poapfel/Yasbf/blob/master/generate.sh#L15).

### Generating everything for the first time: ######

	$ chmod +x ./generate.sh
	$ ./generate.sh

Blog post
--------

	$ cd posts
	
Create a new html file in [this](https://github.com/Poapfel/Yasbf/tree/master/posts) folder and give it a name for example: helloworld.html. The first line of this html file has to be the headline for example: Hello World! The second line defines the date the post was written on(The date has to look like this MM-DD-YY HH:MM for example 12-10-11 13:37). The third line has to be blank. The "real" blog post begins at line 4.
After saving the file you will have to regenerate the blog...

	$ ./generate.sh

Custom Theme
--------

Just modify the [stylesheet](https://github.com/Poapfel/Yasbf/blob/master/style.css). Besides you can always edit the html template files, these are located in the folder ["templates"](https://github.com/Poapfel/Yasbf/tree/master/templates).

License
--------

See [LICENSE.txt](https://github.com/Poapfel/Yasbf/blob/master/LICENSE.txt).

To-Do
--------

- It should only generate files which have changed
- Podcast support
- Disqus Comments (?)
- Polished design
- Optimized code
- and more...

--------

[![Flattr this git repo](http://api.flattr.com/button/flattr-badge-large.png)](https://flattr.com/submit/auto?user_id=Poapfel&url=https://github.com/Poapfel/Yasbf&title=Yasbf&language=en_GB&tags=github&category=software)
