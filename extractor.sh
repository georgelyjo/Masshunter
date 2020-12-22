#!/bin/sh

dir=~/Recon/$1

~/go/bin/waybackurls $1 | anew  $dir/$1_extraction;
~/go/bin/gau $1 | anew $dir/$1_extraction; cat $dir/$1_extraction | sort -u | anew $dir/$1_archive_extracts;
