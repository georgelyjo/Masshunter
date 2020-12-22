#!/bin/sh

dir=~/Recon/$1

 cd ~/go/src/github.com/Ice3man543/SubOver && SubOver -l $dir/$1_subdomains -o $dir/$1_takeover;
