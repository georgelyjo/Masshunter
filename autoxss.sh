dir=~/Recon/$1

echo "$1" | waybackurls | anew $dir/$1.txt

echo "$1" | gau | anew $dir/$1.txt

echo "$1" | hakrawler -depth 5 | anew $dir/$1.txt

cd ~/ParamSpider && ./paramspider -d $1 -o ~/Quickxss/$1/params.txt


cat ~/Quickxss/$1/params.txt | anew $dir/$1_xss.txt


echo -e "\e[1;31m\nFinding valid URLs for XSS \n \e[0m"

cat $dir/$1.txt | gf xss | sed 's/=.*/=/' | grep -v '[0-9]' |  sed 's/URL: //' | anew $dir/$1_xss.txt

rm  ~/Quickxss/$1/params.txt

dalfox file $dir/$1_xss.txt pipe -o $dir/xss_output.txt

cat $dir/xss_output.txt | grep -i poc
