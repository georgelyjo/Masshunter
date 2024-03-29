#!/bin/sh
dir=~/Recon/$1

echo $1| ~/go/bin/gau | grep -iE "\.js$" | uniq | sort | anew $dir/$1_jsfile_links;
echo $1 | ~/go/bin/subjs | anew $dir/$1_jsfile_links;
echo $1 | ~/go/bin/hakrawler -js -depth 2 -scope subs -plain | anew $dir/$1_jsfile_links;

cat $dir/$1_jsfile_links | ~/go/bin/httpx -follow-redirects -silent -status-code | grep "[200]" | cut -d ' ' -f1 | sort -u | anew $dir/$1_live_jsfile_links;

python3 ~/Tools/LinkFinder/linkfinder.py -d -i $1 -o cli | anew $dir/$1_JSEndpoints;

cat $dir/$1_live_jsfile_links | python3 ~/Tools/getjswords.py | sort -u | anew $dir/$1_JSWords;

cat $dir/$1_live_jsfile_links  | while read url ; do bash ~/Tools/jsvar.sh $url | sort -u | tee $dir/$1_JSXSS ; done;
