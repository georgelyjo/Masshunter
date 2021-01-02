dir=~/Recon/$1
mkdir -p $dir
cd /root/bug/Sublist3r && python3 sublist3r.py -d $1 -o $dir/$1_subdomains; 
echo "subfinder"
subfinder -d $1 | anew  $dir/$1_subdomains; 
echo "assetfinder"
assetfinder  --subs-only $1  |  anew  $dir/$1_subdomains; 
echo "domainextractor"
cd /root/bug/domainExtractor && python3 domainExtractor.py --url https://$1 && cat final.$1.txt | anew  $dir/$1_subdomains;
amass enum -d $1 -o $dir/$1_subdomains;
cat /root/bug/$1/sub.txt | anew $dir/$1_subdomains;
echo "crt.sh"
curl -s https://crt.sh/\?q\=\%.$1\&output\=json | jq -r '.[].name_value' | sed 's/\*\.//g' | sort -u | anew $dir/$1_subdomains;
echo "subdrill"
cd /root/arsenal/Sub-Drill/ && bash subdrill.sh $1 | anew $dir/$1_subdomains;


