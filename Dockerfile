#Dockerfile
FROM mcr.microsoft.com/dotnet/core/sdk:3.1 as builder  
 
RUN mkdir -p /root/src/app/SomeAPI
WORKDIR /root/src/app/SomeAPI
 
#copy just the project file over
# this prevents additional extraneous restores
# and allows us to resuse the intermediate layer
# This only happens again if we change the csproj.
# This means WAY faster builds!
COPY SomeAPI.csproj . 
#Because we have a custom one
#COPY nuget.config . 
RUN dotnet restore ./SomeAPI.csproj 

COPY . .
RUN dotnet publish -c release -o published -r linux-x64 

#Smaller - Best for apps with self-contained .NETs, as it doesn't include the runtime
#FROM microsoft/dotnet:2.0.0-runtime-deps-stretch-arm32v7 

#Bigger - Best for apps .NETs that aren't self-contained.
#FROM microsoft/dotnet:2.0.0-runtime-stretch-arm32v7

#FROM microsoft/dotnet:2.0.0-runtime-deps
#FROM microsoft/dotnet:2.0.0-runtime

FROM mcr.microsoft.com/dotnet/core/aspnet:3.1

WORKDIR /root/  
COPY --from=builder /root/src/app/SomeAPI/published .
ENTRYPOINT ["dotnet", "./SomeAPI.dll"]
#ENV ASPNETCORE_URLS=http://+:5000
#EXPOSE 80:5000/tcp
#CMD ["dotnet", "./SomeAPI.dll"]  
#CMD ["./SomeAPI"] 
