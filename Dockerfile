# Dockerfile for phl-airflow
# find it here: https://github.com/CityOfPhiladelphia/phl-airflow
# pull Ubuntu (16.04) base image
FROM ubuntu

# set maintainer
MAINTAINER Nick Weber <nicholas.weber@phila.gov>

# update local package database
RUN apt-get -y update 

# install editors
Run apt-get install -y vim && apt-get install -y nano
#RUN git clone git://github.com/amix/vimrc.git ~/.vim_runtime ; sh ~/.vim_runtime/install_basic_vimrc.sh

# install phl-airflow dependencies
RUN apt-get install -y build-essential libssl-dev libffi-dev
RUN apt-get install -y python 
RUN apt-get install -y python-pip 
RUN apt-get install -y postgresql 
RUN apt-get install -y postgresql-contrib
RUN apt-get install -y python-setuptools 
RUN apt-get install -y libc-dev-bin 
RUN apt-get install -y libc-dev 
RUN apt-get install -y python-dev 
RUN apt-get install -y libpq-dev
## install airflow
RUN pip install "airflow[postgres]"
RUN pip install cryptography Celery

# install redis
RUN apt-get install -y redis-tools

# clone phl-airflow
RUN apt-get install -y git alien wget libaio1

# grab instant sql-plus instant oracle client/ rename downloaded file and install with alien
RUN wget https://www.dropbox.com/s/ubgeht3m59bhfh1/oracle-instantclient12.1-sqlplus-12.1.0.2.0-1.x86_64.rpm?dl=0
RUN mv oracle-instantclient12.1-sqlplus-12.1.0.2.0-1.x86_64.rpm\?dl\=0 oracle-instantclient12.1-sqlplus-12.1.0.2.0-1.x86_64.rpm
RUN alien -i oracle-instantclient12.1-sqlplus-12.1.0.2.0-1.x86_64.rpm 

# grab instant basic-lite instant oracle client/ rename downloaded file and install with alien
RUN wget https://www.dropbox.com/s/1yzl0fdnaiw5yqp/oracle-instantclient12.1-basiclite-12.1.0.2.0-1.x86_64.rpm?dl=0
RUN mv oracle-instantclient12.1-basiclite-12.1.0.2.0-1.x86_64.rpm?dl=0 oracle-instantclient12.1-basiclite-12.1.0.2.0-1.x86_64.rpm
RUN alien -i oracle-instantclient12.1-basiclite-12.1.0.2.0-1.x86_64.rpm 

# grab instant oracle-sdk / rename downloaded files and install with alien
RUN wget https://www.dropbox.com/s/uic5vzc9yobttct/oracle-instantclient12.1-devel-12.1.0.2.0-1.x86_64.rpm?dl=0
RUN mv oracle-instantclient12.1-devel-12.1.0.2.0-1.x86_64.rpm?dl=0 oracle-instantclient12.1-devel-12.1.0.2.0-1.x86_64.rpm
RUN alien -i oracle-instantclient12.1-devel-12.1.0.2.0-1.x86_64.rpm

# set oracle environment variables
ENV LD_LIBRARY_PATH /usr/lib/oracle/12.1/client64/lib/${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}
ENV ORACLE_HOME /usr/lib/oracle/12.1/client64

# geospatial dependencies
RUN apt-get install -y libgdal-dev libgeos-dev binutils libproj-dev gdal-bin
RUN apt-get install -y libspatialindex-dev

# clone phl-airflow
RUN git clone https://github.com/CityOfPhiladelphia/phl-airflow.git ~/phl-airflow ; cd ~/phl-airflow

# setup $AIRFLOW_HOME
ENV AIRFLOW_HOME=~/phl-airflow
ENV AIRFLOW__CORE__EXECUTOR=CeleryExecutor
ENV AIRFLOW__CORE__LOAD_EXAMPLES=False
ENV AIRFLOW__CORE__SQL_ALCHEMY_CONN=my_conn_string

# initialize database
# RUN airflow initdb

# install dependencies
RUN pip install -r ~/phl-airflow/requirements.txt

USER root
