FROM linuxmintd/mint20-amd64

# prerequirements
RUN apt update && apt install -y sudo git

# create a non-root user
RUN sudo adduser test --gecos "Test" --disabled-password
RUN echo "test:foobar" | chpasswd
RUN usermod -aG sudo test

COPY . home/test/dotfiles
RUN rm -rf home/test/shell/temp_settings.sh

RUN sudo chown -R test home/test/dotfiles

USER test
WORKDIR home/test/dotfiles
