FROM linuxmintd/mint20-amd64
# prerequirements
RUN apt-get update && apt-get install -y sudo git

COPY . /root/dotfiles

WORKDIR /root/dotfiles
ENTRYPOINT ["bash", "-l"]
