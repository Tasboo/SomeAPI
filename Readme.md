Important Commands

Build the docker files into an image called someapi (to be called from directory of Dockerfile. If code or dockerfile changes, this needs to be re-ran)
docker build -t someapi .

Create and run new container called myapi (run in the background -d), expose it on port 8080 through port 80 (-p) using image someapi
sudo docker run -d -p 8080:80 --name myapi someapi

After running those 2 commands in the WSL Ubuntu terminal, you should be able to browse to http://localhost:8080/WeatherForecast in a browser through a browser in Windows


Other commands
Remove existing container
docker rm myapi

List all running containers
docker ps

List all images
docker images ls


Referenced Resources:
Getting WSL2 and Docker desktop installed, setting up docker file
https://www.hanselman.com/blog/MovingAnASPNETCoreFromAzureAppServiceOnWindowsToLinuxByTestingInWSLAndDockerFirst.aspx

Setting up docker file and .dockerignore. Running docker container and exposing endpoint 
https://softchris.github.io/pages/dotnet-dockerize.html#create-a-dockerfile 
