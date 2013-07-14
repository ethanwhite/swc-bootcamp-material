The Shell
=========

Introduction
------------

We're here to teach you about computers and computers really do four things:

* run programs
* store data 
* communicate with each other
* and interact with us

They can do the last of these in many different ways.
The most common way of doing this is using a graphical interface.
Another way to do this is using a command line text interface called the shell.

The shell is very useful for three main reasons:

1. Automating data analysis
2. Combining existing tools in powerful ways with only a few keystrokes
3. Interacting with remote machine

*Start shell in SWC directory with example files?*

**Open a terminal;
Windows open GitBash;
Mac type 'terminal' into the Finder;
STICKIES**

Files and Directories
---------------------

### Viewing the file system

Now that we have a shell open let's see where we are.

    pwd

This stands for "print working directory" and tells us where we are in the file
system. Your terminal probably started in your home directory like mine
did. This is just like using the graphical file browser on your computer.  We
can interact with files and directories/folder using the command line.

To take a look at what's in the current directory use

    ls
	
which stands for "listing". This will print out a list of files and directories
just like those shown in the GUI. In some cases the directories will be colored
but if not we can see which names are directories and which are files by
using the -F argument

    ls -F
	
which adds a trailing slash to the directories.
Dash is how you introduce options.

### Changing directories

To change directories

    cd swc
	
Since ``swc`` is in our current directory we can just type it's name.
We can also specify the full path to allow us to jump to other areas.

    cd /home/ethan/
	
Windows users need to start full paths with the drive letter.

    cd /c/Users/username

**Change directories;
use pwd to see where you are;
use ls to list the contents**

#### Autocomplete

If this is starting to feel like a lot of typing use tab.

    cd /h<tab>/e<tab>/U<tab>
	
If nothing happens then either there is nothing to complete or there is too
much. A second ``<tab>`` will show you the available options.

Rule #1. If the computer can do it, let the computer do.

### Making directories

We can add new directories using

    mkdir swc
	
**Add a swc directory for us to work in today;
Change directories**

### Making files

To make files in the shell we use simple text editors.
I'm going to use nano today since it's one of the most basic.
To make a new file we simply type ``nano`` and then the name of the file.
Let's make a simple data file:

    nano data.txt
	
I can then enter some data the birds that I saw at my field site:

    2013-03-22 bluejay 5
	2013-03-22 mallard 9
	2013-03-21 robin 1
	...
	
Control-O saves the file (the ^ in most unix documentation means Control)
Control-X exits

You can use your favorite text editor for this including graphical ones
if you don't have nano setup.

*Demonstrate the same thing using gedit creating a new data2.txt file*

**Create a data.txt file just like this one;
the raw data is pasted into the etherpad;
use ls to confirm that your file exists**

### Copying, Moving, Renaming, and Deleting Files

We can make copies of files using ``cp``

    cp data.txt data_copy.txt
	ls

And we can move files using ``mv``

    mkdir temp
	ls
	mv data_copy.txt temp
	ls
	cd temp
	ls

We can also use mv to rename files using ``mv`` by "moving" them to a new
file name. Since ``data.txt`` isn't very informative let's give it a
meaningful file name so that we remember what it actually contains.

    mv data.txt data_greencanyon_2013.txt
	ls

**Create a backup of your datafile, you do keep backups of your data right?;
Make a directory called backup;
Make a copy of your data.txt file;
Move it into the backup folder;
Give both the original data file and the backup file meaningful names**

If need to get rid of any extra files you can remove them

    cp data_greencanyon_2013.txt more_data.txt
	ls
	rm more_data.txt
	ls

**BREAK: When we come back we'll learn about how to harness the power of the
shell for automatic data analysis**

### Shell Programs and Redirects

Now that we know how to work with the shell we can use it to do powerful things
by combining lots of small built in programs.

Let's say we need to find the data row with the most species.

Let's start by looking at the data in our file. *always a good idea*
We can do this in the shell using the ``cat`` command. This stands for
concatenate.

    cat data_greencanyon_2013.txt

We can start by sorting the data

    sort data_greencanyon_2013.txt

This sorts things but it sorts them by the wrong column, so we can tell the 
shell to sort based on the second column by giving it an optional argument.
To find out what this argument is we can use --help.

    sort --help
	
*To avoid retyping the original line use the up arrow.*
	
    sort data_greencanyon_2013.txt -k 3
	
We can now look at the bottom of the output and see the most abundant species,
but we'd like to be able to store that information for later use.

To store the output as a file we use a > sign.

    sort data_greencanyon_2013.txt -k 3 > sorted_counts.txt
	cat sorted_counts.txt
	
Now we've got a sorted list, but we really just want the data on the most
common species. We can get the end of the file using ``tail``

    tail sorted_counts.txt
	tail -1 sorted_counts.txt

**EXERCISE: Find the row with the fewest individuals and print it's info;
You'll need to use either head, the opposite of tail, or add an argument
to sort; use --help to get more information**

### History

### Pipes

We can also skip the intermediate files by using pipes.
Pipes pass the data that would have gone into the intermediate program
straight to the next program.

So, the commands we just wrote:

    sort data_greencanyon_2013.txt -k 2 > sorted_counts.txt
	head sorted_counts.txt -1

can be written like this:

    sort data_greencanyon_2013.txt -k 2 | head -1
	
**Use pipes with sort, head, and tail to find the data row with the second most
individuals**

### Other people's programs

Piping together unix tools can be very powerful for automating data analysis.
I often use this for quick sanity checks on much more complicated Python code,
But the real power of the piping in my every day life is piping my tools and other
scientists tools together. This makes it easy to use tools written in languages
you're not familiar with and to combine tools from different languages.

So, let's say we want to count the total number of individuals of each species
that were seen in Green Canyon in 2013. We might be able solve this problem
ourselves, but our lab mate has already written some code that does this.
Instead of rewriting the code ourselves we can simply add it to a pipeline.

*The code is available on the etherpad*

To run this code we need to tell the shell to run it using python, which we do
by giving it the name of the program that will run it, then the name of our
program, and then the input.

    python species_counts.py data_greencanyon_2013.txt
	
This can then be integrated into our pipeline. So if we want to sort based
on the total number of individuals:
	
    python species_counts.py testdata.txt | sort -k 2

**EXERCISE: Create a text file that contains the counts of each species sorted
alphabetically by species name.**


### Wild cards

This is great for one file, but what if we have lots of files.

*Add new data files*

We can use wildcards to work with multiple files at once.
For example,

    cat *.txt

This concatenates all of the files ending in .txt together.
The shell expands the wildcard before executing cat, so this is identical to

    cat data_greencanyon_2013.txt data_drycanyon_2013.txt data_logancanyon_2013.txt
	
We can use this to get the most common species at any of the sites

    cat *.txt | python species_counts.py | sort -k 2 | tail -1
	
### Loops

    for datafile in *.txt
	do
	    echo $datafile
		python species_counts.py $datafile
	done

**EXERCISE: Write a loop that prints out the name of each datafile followed by
the most common species in that datafile.**

### Scripts

Once we have the commands that we want working, we often want to use them again.
To do this easily we can store them in a script. We do this by adding the
commands to a text file and then running that text file from the command line:

    bash most_common.sh

### History
