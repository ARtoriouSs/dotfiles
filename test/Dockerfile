FROM ubuntu:18.04

# prerequirements
RUN apt-get update && apt-get install -y sudo git

COPY . /root/dotfiles

WORKDIR /root/dotfiles
ENTRYPOINT ["bash", "-l"]
