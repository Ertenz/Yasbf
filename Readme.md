# Yasbf #

A very dirty static blogging framework.

How to install it?
--------

### Getting the source: ######

	$ git clone git://github.com/Poapfel/Yasbf.git

### Basic configuration: ######

Open the file generate.sh with your favorite text editor and fill in the informations from line [9](https://github.com/Poapfel/Yasbf/blob/master/generate.sh#L9) to line [13](https://github.com/Poapfel/Yasbf/blob/master/generate.sh#L13), do not edit anything below line [14](https://github.com/Poapfel/Yasbf/blob/master/generate.sh#L14) if you don't now what you are doing! 
Besides you have to uncomment or remove the line [14](https://github.com/Poapfel/Yasbf/blob/master/generate.sh#L14) else it will not work.

### Generating everything for the first time: ######

At the Command line just enter

	$ chmod +x ./generate.sh
	$ ./generate.sh

You have sucessfull generated your fist Yasbf site.

How to write a Blog Post?
--------

Creating new Blog post is relativly simple, just create a html file in the folder [posts](https://github.com/Poapfel/Yasbf/tree/master/posts), be carefull the filename should not contain any special characters. To define a headline just enter the headline in the very first line of your Blog Post, leave the second line blank and the 'real' Blog post begins at the third line. 
Besides you can use normal html tags like a href and so on in your Blog Posts...
And don't forget to regenerate the entire Blog after saving the Blog Post...

	$ ./generate.sh

**Example:**
Create a file named zombies.html in the posts Folder and add the following content to it...

	Zombie Ninjas Attack: A survivor's retrospective
	
	<a href="https://en.wikipedia.org/wiki/Lorem_ipsum">Lorem ipsum</a> dolor sit amet, consectetur adipiscing elit. Morbi ac nisi at tortor 
	ultrices rhoncus ac quis sem. Aenean lorem metus, tempor nec suscipit quis, vestibulum vitae urna. 
	Aliquam ac interdum nulla. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. 
	Nam posuere faucibus velit et consequat. Nullam ut lacus felis. Etiam dignissim interdum purus. Nulla convallis purus eu justo faucibus 
	id rhoncus sapien interdum. Mauris justo erat, accumsan ut dignissim non, rutrum a risus.
	<br/><br/>
	Integer fermentum laoreet facilisis. <strong>Aliquam</strong> dapibus tristique felis, interdum tempor eros fringilla eu. 
	Donec auctor vulputate neque, et mattis risus lobortis et. Mauris placerat sodales lacus, id auctor mauris placerat nec. 
	Donec quis eros eget dui pharetra dapibus. Donec gravida mi nec odio lobortis eu vehicula quam bibendum. Etiam non nulla urna. 
	Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Aenean venenatis eleifend leo, sit amet posuere 
	tellus gravida id. Morbi interdum ipsum eget nunc varius sollicitudin.


How to apply a custom Theme?
--------

Well...that's not that hard, just modify the [css stylesheet](https://github.com/Poapfel/Yasbf). For andvanced configuration modify the html files in the folder [templates](https://github.com/Poapfel/Yasbf/tree/master/templates).

How to migrate from Wordpress to Yasbf?
--------

I didn't test this myself...but it should work... just use [this](https://github.com/jainbasil/htmlGenerator) tool to Convert all your Wordpress Posts into raw html files...the only thing you have to do then is moving all html files it has generated to the [posts](https://github.com/Poapfel/Yasbf/tree/master/posts) folder.

To-Do
--------

- RSS Feed
- "Real" Archives
- Polished design
- Optimized code
- and more...

--------

[![Flattr this git repo](http://api.flattr.com/button/flattr-badge-large.png)](https://flattr.com/submit/auto?user_id=Poapfel&url=https://github.com/Poapfel/Yasbf&title=Yasbf&language=en_GB&tags=github&category=software)
