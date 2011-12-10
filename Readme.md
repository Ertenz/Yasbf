# Yasbf #

A very dirty static blogging framework.

How to install it?
--------

### Getting the source: ######

	$ git clone git://github.com/Poapfel/Yasbf.git
	$ mv Yasbf weblog
	$ cd weblog

### Basic configuration: ######

Open the file generate.sh with your favorite text editor and fill in the informations from line 9 to line 13, do not edit anything below line 13 if you don't now what you are doing! Besides you have to uncomment or remove the line 14 else it will not work.

### Generating everything for the first time: ######

At the Command line just enter

	$ chmod +x ./generate.sh
	$ ./generate.sh

You have sucessfull generated your fist Yasbf site.

How to write a Blog Post?
--------

Creating new Blog post is relativly simple, just create a html file in the folder 'posts', be carefull the filename should not contain any special characters. To define a headline just enter the headline in the very first line of your Blog Post, leave the second line blank and the 'real' Blog post begins at the third line. 
<hint>You can use normal html tags like <a href> and so on in your Blog Posts...</hint>
And don't forget to regenerate the entire Blog after saving the Blog Post...

	$ ./generate.sh

**Example:**
Create a file named zombies.html in the posts Folder and add the following content to it...

	Zombie Ninjas Attack: A survivor's retrospective
	
	<a href="https://en.wikipedia.org/wiki/Lorem_ipsum">Lorem ipsum</a> dolor sit amet, consectetur adipiscing elit. Morbi ac nisi at tortor ultrices rhoncus ac quis sem. A	enean lorem metus, tempor nec suscipit quis, vestibulum vitae urna. Aliquam ac interdum nulla. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Nam posuere faucibus velit et consequat. Nullam ut lacus felis. Etiam dignissim interdum purus. Nulla convallis purus eu justo faucibus id rhoncus sapien interdum. Mauris justo erat, accumsan ut dignissim non, rutrum a risus.
	<br/><br/>
	Integer fermentum laoreet facilisis. <strong>Aliquam</strong> dapibus tristique felis, interdum tempor eros fringilla eu. Donec auctor vulputate neque, et mattis risus lobortis et. Mauris placerat sodales lacus, id auctor mauris placerat nec. Donec quis eros eget dui pharetra dapibus. Donec gravida mi nec odio lobortis eu vehicula quam bibendum. Etiam non nulla urna. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Aenean venenatis eleifend leo, sit amet posuere tellus gravida id. Morbi interdum ipsum eget nunc varius sollicitudin.


How to apply a custom Theme?
--------

Well...that's not that hard, just modify the css stylesheet. For andvanced configuration modify the html files in the folder templates.

