# Docker-airflowphl

## To build Dockerfile locally:

```bash
# clone the repository:
git clone https://github.com/nwebz/Docker-airflowphl.git && cd Docker-airflowphl

# to build Dockerfile run:
docker build -t <container tag> </path/to/Dockerfile>

# Or pull from Docker index:
docker pull nwebz/phl-airflow7

# run container:
docker run -t -d <Image>

# enter container:
sudo docker exec -it  <ContainerID> /bin/bash

# start airflow webserver:
airflow webserver -p 8080

# locate containers ip:
docker inspect <ContainerID> | grep IPAddress

# navigate to airflow admin with:
<ContainerIP>:<port>

```
