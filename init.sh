#/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo -e "${GREEN}Pull and start local registry${NC}"
docker run -d -p 5000:5000 --name registry -v "registry:/var/lib/registry/" registry:2

echo -e "${GREEN}Building nginx image and push it into local registry${NC}"
pushd nginx
docker build -t nginx-a .
docker tag nginx-a localhost:5000/nginx-a
docker push localhost:5000/nginx-a
popd

echo -e "${GREEN}Building apache image and push it into local registry${NC}"
pushd apache
docker build -t httpd-a .
docker tag httpd-a localhost:5000/httpd-a
docker push localhost:5000/httpd-a
popd
echo "done"

echo -e "${GREEN}Prepare docker environment and generate index page${NC}"
docker volume create website
website_path=$( docker volume inspect website | sed -nr '/Mountpoint/s/.*: "(.*)",/\1/p' )
cat>"$website_path/index.html"<<EOF
<html><body><h3>Hello there!</h3></body></html>
EOF
