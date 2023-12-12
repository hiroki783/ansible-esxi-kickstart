FROM python:3.11

RUN apt-get update && apt-get -y upgrade && apt-get -y install genisoimage p7zip-full
RUN pip install ansible

CMD ansible