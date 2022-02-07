For development:

#docker build -f Dockerfile.dev -t dnw2022/dnw-react .
docker-compose build
ID=$(docker-compose run -d --rm sdk)
docker exec -it $ID bash

git clone https://github.com/BorisWilhelms/create-dotnet-devcert.git
./create-dotnet-devcert/scripts/ubuntu-create-dotnet-devcert.sh

https://docs.microsoft.com/en-us/visualstudio/containers/container-tools-react?view=vs-2022
https://mahdikarimipour.com/blog/containerise-react-app-with-aspnet-and-azure-devops

https://stackoverflow.com/questions/25845538/how-to-use-sudo-inside-a-docker-container

For the production build:

docker build -f Dockerfile -t dnw2022/dnw-react .
docker run -p 5050:5050 dnw2022/dnw-react --rm -it (-p should be before the image!)
ASPNETCORE_URLS can be used to control the port that kestrel listens on

Azure webapp deployment

az webapp up --sku B1 --location westeurope --name dnwreact --os-type linux  --resource-group dnw-rg  --plan dnw-plan