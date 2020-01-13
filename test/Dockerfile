FROM ubuntu:18.04

# prerequirements
RUN apt-get update && apt-get install -y sudo git

COPY . ~/dotfiles

WORKDIR ~/dotfiles
CMD ["bash"]
