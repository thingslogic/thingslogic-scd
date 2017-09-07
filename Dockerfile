FROM ubuntu:17.04

# Install CrateDB

RUN apt-get update
RUN apt-get install -y wget
RUN wget https://cdn.crate.io/downloads/deb/DEB-GPG-KEY-crate
RUN apt-key add DEB-GPG-KEY-crate
RUN echo "deb https://cdn.crate.io/downloads/deb/stable/ zesty main" > /etc/apt/sources.list.d/crate.list
RUN apt-get install -y apt-transport-https
RUN apt-get update
RUN apt-get install -y crate


ADD config/crate.yml /etc/crate/crate.yml
ADD config/log4j2.properties /etc/crate/log4j2.properties


# Install NodeRed

RUN apt-get update
RUN apt-get install -y nodejs-legacy npm
RUN npm install -g --unsafe-perm node-red node-red-admin

# Install Grafana

RUN echo "deb https://packagecloud.io/grafana/stable/debian/ jessie main" > /etc/apt/sources.list.d/grafana.list
RUN wget -q -O- https://packagecloud.io/gpg.key | apt-key add
RUN apt-get update
RUN apt-get install -y grafana



# Crate Port, Gravana Port, NodeRed Port
EXPOSE 4200 4300 5432-5532 3000 1880

# Run everything
CMD service crate start | service grafana-server start | node-red | wc -
