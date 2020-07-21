FROM linuxmintd/mint20-amd64

# prerequirements
RUN apt update && apt install -y sudo git

# create a non-root user
RUN sudo adduser test --gecos "Test" --disabled-password
RUN echo "test:foobar" | chpasswd
RUN usermod -aG sudo test
HOME home/test

COPY . ~/dotfiles
RUN rm -f ~/dotfiles/shell/temp_settings.sh
RUN sudo chown -R ~/dotfiles

USER test
WORKDIR ~/dotfiles
