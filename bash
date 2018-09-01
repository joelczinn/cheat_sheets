################################################################
# collapse down to unique array elements:
################################################################
unique_array=($(echo "${array_w_repeats[@]}" | tr ' ' '\n' | sort -u | tr '\n' ' '))

################################################################
# delete file from .tar
################################################################
tar TAR.TAR --delete tmp
# will delete the file tmp from TAR.TAR. Haven't figured out how to make wildcards work with this command...

################################################################
# show differences between directories -- just filenames and which ones
# are unique to each directory and which ones are common but different
################################################################
diff -qr dir_one dir_two | sort

################################################################
# xargs and conditional statements
################################################################
ls *.pds | head -n 10 | xargs -I % wc -l % | xargs -I % bash -c 'if [ $(echo % | cut -f 1 -d " " ) -gt "30000" ]; then echo $(echo % | cut -f 2 -d " ") >> tmp_zinn.txt ; else echo "no"; fi'

################################################################
# sequences
################################################################
# see https://stackoverflow.com/questions/8789729/how-to-zero-pad-a-sequence-of-integers-in-bash-so-that-all-have-the-same-width
for i in `seq -w $beg $end`; do echo $i; done

################################################################
# replace string
################################################################
# see https://stackoverflow.com/questions/13210880/replace-one-substring-for-another-string-in-shell-script
${STRING/THING_TO_REPLACE/$THING_TO_REPLACE_WITH}

################################################################
# temporary unaliasing
################################################################
# see http://stackoverflow.com/questions/8488253/how-to-force-cp-to-overwrite-without-confirmation
add a backslash in front!
\cp

################################################################
# extract basename 
################################################################
"${file%*.EXT}"
to get only the extension:
"${file##*.}"

################################################################
# trim whitespace in figure
################################################################
# see http://www.imagemagick.org/discourse-server/viewtopic.php?t=15675
# the above apparently works with png files that have transparent parts in them...?
convert partial-trans.png -flatten -fuzz 1% -trim +repage trimmed.jpg


################################################################
# patching library packages
################################################################
if you don't want to (or more likely, don't have the permissions to) reinstall a package that depends on some libraries that are for some reason broken, try replacing the libraries
with the LD_PRELOAD variable, like so:
bash; LD_PRELOAD=/path/to/lib/libLIB.so python -c "import package_that_needs_libLIB"

works in BASH OF COURSE BECAUSE THAT IS BASH SYNTAX NOT CSHELL

################################################################
# loop over numbers
################################################################
for ((i=1;i<=$n;i++)); do echo $i; done

################################################################
# restart gnome-shell from command line
################################################################
killall -3 gnome-shell
# restart gnome-shell from alt+F2 then do command 'restart' works too

################################################################
# renaming files with sed
################################################################
for f in ./DIR/*bgmodel ; do mv "$f" $(echo $f | sed s/\STR_TO_DELETE//) ; done

################################################################
# functions, not aliases
# see http://unix.stackexchange.com/questions/1496/why-doesnt-my-bash-script-recognize-aliases
################################################################
# functions are preferred over aliases.
# aliases are not expanded in non-interactive shells.

foo()
{
    echo "Hello World!"
}
export -f foo

################################################################
# arguments and positional parameters
################################################################
# from Aleksandr Tsertkov on devhands

while getopts r option ; do
case $option in
    r) run=1 ;;
esac

done

if [ $(( $#-$OPTIND )) -lt 0 ]; then
    echo "Usage : [-r ] kind"
    exit 1
fi

kind=${@:$OPTIND:1}

################################################################
# length of string
################################################################
# see http://www.tldp.org/LDP/abs/html/string-manipulation.html FOR ALL BASH VARIABLE QUESTIONS !!!
${#VAR}

################################################################
# select all elements in a list
################################################################
${array_name[@]}

################################################################
# make bash default without chsh or admin privileges
################################################################
# remove sleep 2 if it works
add to ~/.login:
sleep 2
if (-x /usr/local/bin/bash) then
  exec /usr/local/bin/bash -l
endif

################################################################
# make tab-complete not case-sensitive
################################################################
set completion-ignore-case on

# Same in tcsh (~/.tcshrc):

set complete = enhance

################################################################
# command history
################################################################
history

# then to re-execute command 123
!123

# to redo the last one
!!

################################################################
# multiline comments
################################################################
: '
COMMENT
COMMENT
'

# (for some reason the space between : and ' is necessary)

# OR

<< COMMENT
asdfasd
asdf
COMMENT


################################################################
# get Centos version
################################################################
lsb_release -d

################################################################
# making a video out of .png files
################################################################

ffmpeg -start_number 00 -i FILES_%02d.png -c:v libx264 -pix_fmt yuv420p output.mpg
where the files are of the format :
FILES_00.png
FILES_01.png
FILES_02.png

# etc.
# the %02d indicates it expects 2-digit numbers starting with 00 (-start_number 00)
# the -c:v ... optinos make PNG files compatible for mpgeg4 players by converting pixel format to "chroma-subsampled YUV"

################################################################
# if get error from configure
################################################################
# see http://askubuntu.com/questions/27677/cannot-find-install-sh-install-sh-or-shtool-in-ac-aux
# try this :
$ libtoolize --force
$ aclocal
$ autoheader
$ automake --force-missing --add-missing
$ autoconf
$ ./configure

################################################################
# lines in one file but not another
################################################################
$ cat A.txt
1
4
112
$ cat B.txt
1
112
# Bad:
$ comm -2 -3 <(sort -n B.txt) <(sort -n B.txt)
4
comm: file 1 is not in sorted order

# OK:
$ comm -2 -3 <(sort A.txt) <(sort B.txt)
4

################################################################
# duplicate / unique values in file
################################################################
sort FILE | uniq

################################################################
# send job to a particular core
################################################################
see http://xmodulo.com/run-program-process-specific-cpu-cores-linux.html

taskset -cp 0,4 COMMAND

# With "-c" option, you can specify a list of numeric CPU core IDs separated by commas, or even include ranges (e.g., 0,2,5,6-10).
# Note that in order to be able to change the CPU affinity of a process, a user must have CAP_SYS_NICE capability. Any user can view the affinity mask of a process.

################################################################
# prepend a line to a file
################################################################
sed -i ‘1i Prepended line’ /tmp/newfile
# where the line will start right at "P" in Prepended, without the space. space still needed, though.

################################################################
# top broken down by core -- multiprocessing ; mp ; thread
################################################################
# see http://stackoverflow.com/questions/5899227/view-multi-core-or-mlti-cpu-utlization-on-linux
# When runnging the top command, press f then j to display the P column (last CPU used by process), in addition to the 1 command in top, you should view some multi core occupation informations :)

################################################################
# split files
################################################################
# split FILE into N files
split -l N FILE

################################################################
# merge PDFs
################################################################
gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=finished.pdf file1.pdf file2.pdf

################################################################
# to find where a link points to
################################################################
# see http://superuser.com/questions/12972/how-can-you-see-the-actual-hard-link-by-ls
ls -l
# shows references count (number of hardlinks to particular inode)

# after you found inode number, you can search for all files with same inode:

find . -inum NUM


################################################################
# search for an indexed file
################################################################
locate

################################################################
# list files in memory order
################################################################
find . -maxdepth 1 -print0 | xargs -0 du -h | sort -h

################################################################
# length of array
################################################################
${#ARRAY}

################################################################
# unpack .jar file	
################################################################
# apparently a .jar file is just a .zip file (http://stackoverflow.com/questions/2114929/best-method-for-jar-extraction-in-unix-linux). thus :
unzip FILE.jar

################################################################
# how many cores computer has
################################################################
import multiprocessing as mp
mp.cpu_count()

################################################################
# unzip .zip file
################################################################
unzip FILE.zip

################################################################
# fix 403 Forbidden error in wget
################################################################
# if 
# wget http://arxiv.org/pdf/1309.4455v1
# fails, try:

wget -U firefox http://arxiv.org/pdf/1309.4455v1

################################################################
# uncompress bz2 file
################################################################

tar xjvf FILE.tar.bz2

################################################################
# finding mac address
################################################################
# HAVE TO BE USING THE CONNECTION THAT YOU WANT THE MAC ADDRESS FOR.
# mac :

ifconfig | grep ether

# linux:

ifconfig | grep ether

################################################################
# regex
################################################################
if [[ $vartobesearched =~ regexthing ]]; then

################################################################
# fit-to-page when printing
################################################################
# ... doesn't seem to work for the dept printers. instead what i've done is this:
find ../../plots -maxdepth 1 -mmin -40 -type f -name "*.jpg" | xargs -I % okular %

# okular knows how to print fitted-to-page style.
# just did
ctrl+p
enter
ctrl+q
# for each window

################################################################
# convert eps to high-quality jpg
################################################################
convert -density 300 FILE.eps -resize 1024x1024 FILE.jpg

################################################################
# dealing with bad exits
################################################################
# use trap to do default things when a process is interrupted. e.g., 
#!/bin/bash
set -e
trap 'echo aborted; exit' SIGINT SIGTERM
sleep 10


exit


################################################################
examine open files (for a particular PID)
################################################################
losf -p ###

# or to list them all:

lsof

################################################################
# run job in background
################################################################
# OPTION 1
# can just suspend it then put in bg with bg and then disown -h ID to make it so you can then exit from the shell without it cutting out, which you do with exit command.
# OPTION 2
# for redirecting output, follow these steps :
# Firstly I run the command “cat > foo1” in one session and test that data from stdin is copied to the file. Then in another session I redirect the output:

# Firstly find the PID of the process:
$ ps aux|grep cat
rjc 6760 0.0 0.0 1580 376 pts/5 S+ 15:31 0:00 cat

Now check the file handles it has open:
$ ls -l /proc/6760/fd
total 3
lrwx—— 1 rjc rjc 64 Feb 27 15:32 0 -> /dev/pts/5
l-wx—— 1 rjc rjc 64 Feb 27 15:32 1 -> /tmp/foo1
lrwx—— 1 rjc rjc 64 Feb 27 15:32 2 -> /dev/pts/5

# Now run GDB:
$ gdb -p 6760 /bin/cat
GNU gdb 6.4.90-debian
Copyright (C) 2006 Free Software Foundation, Inc
[lots more license stuff snipped]
Attaching to program: /bin/cat, process 6760
# [snip other stuff that’s not interesting now]

(gdb) p close(1)
$1 = 0
(gdb) p creat(“/tmp/foo3″, 0600)
$2 = 1
(gdb) q
The program is running. Quit anyway (and detach it)? (y or n) y
Detaching from program: /bin/cat, process 6760

# The “p” command in GDB will print the value of an expression, an expression can be a function to call, it can be a system call… So I execute a close() system call and pass file handle 1, then I execute a creat() system call to open a new file. The result of the creat() was 1 which means that it replaced the previous file handle. If I wanted to use the same file for stdout and stderr or if I wanted to replace a file handle with some other number then I would need to call the dup2() system call to achieve that result.

# For this example I chose to use creat() instead of open() because there are fewer parameters. The C macros for the flags are not usable from GDB (it doesn’t use C headers) so I would have to read header files to discover this – it’s not that hard to do so but would take more time. Note that 0600 is the octal permission for the owner having read/write access and the group and others having no access. It would also work to use 0 for that parameter and run chmod on the file later on.

# After that I verify the result:

ls -l /proc/6760/fd/
total 3
lrwx—— 1 rjc 


################################################################
# rsync filters
################################################################
# see http://unix.stackexchange.com/questions/2161/rsync-filter-copying-one-pattern-only
# to just copy *.pdf files :
rsync -am --include='*.pdf' --include='*/' --exclude='*'

# rsync time filter:
find . -newermt "2010-11-23 16:52:50" -print0 | rsync -vuptn -0 --files-from=- . DIR/

# long string options
#!/usr/bin/env bash 
optspec=":hv-:"
while getopts "$optspec" optchar; do
    case "${optchar}" in
        -)
            case "${OPTARG}" in
                loglevel)
                    val="${!OPTIND}"; OPTIND=$(( $OPTIND + 1 ))
                    echo "Parsing option: '--${OPTARG}', value: '${val}'" >&2;
                    ;;
                loglevel=*)
                    val=${OPTARG#*=}
                    opt=${OPTARG%=$val}
                    echo "Parsing option: '--${opt}', value: '${val}'" >&2
                    ;;
                *)
                    if [ "$OPTERR" = 1 ] && [ "${optspec:0:1}" != ":" ]; then
                        echo "Unknown option --${OPTARG}" >&2
                    fi
                    ;;
            esac;;
        h)
            echo "usage: $0 [-v] [--loglevel[=]<value>]" >&2
            exit 2
            ;;
        v)
            echo "Parsing option: '-${optchar}'" >&2
            ;;
        *)
            if [ "$OPTERR" != 1 ] || [ "${optspec:0:1}" = ":" ]; then
                echo "Non-option argument: '-${OPTARG}'" >&2
            fi
            ;;
    esac
done






################################################################
# substrings in bash
################################################################
${var:0:-1}

################################################################
# for loops with iteration number
################################################################
for i in {0..10}
do 
BLAH
done

# {x..y} won't work for variable length arrays, x and y.
instead use
for i in `seq 0 $Y`
do 
BLAH
done

################################################################
# delete all hidden directories
################################################################
$ find /path/to/dest/ -iname ".*" -maxdepth 1 -type d -exec rm -rf {} \;
# If you removed -maxdepth 1 it will find all subdirectories and remove them too.

################################################################
# suspend and unsupend job:
################################################################
^Z
%

################################################################
# screenshot
################################################################
import -window root screenshot.jpg

################################################################
# rename something:
################################################################
rename "texttoreplace" "replacementtext" FILES

################################################################
# find empty file and delete it
################################################################
find . -type f -empty -delete

################################################################
# read file line by line for loop
################################################################
IFS="/n"
while read LINE ; do
BLAH
done < FILE

