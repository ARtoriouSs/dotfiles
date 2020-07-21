FROM linuxmintd/mint20-amd64

# prerequirements
RUN apt-get update && apt-get install -y sudo git

# create a non-root user
RUN sudo adduser testuser --gecos "Test" --disabled-password
RUN echo "testuser:pass" | chpasswd
RUN usermod -aG sudo testuser

COPY . home/testuser/dotfiles
RUN rm -rf home/testuser/shell/temp_settings.sh

RUN sudo chown -R testuser home/testuser/dotfiles

USER testuser
WORKDIR home/testuser/dotfiles
ENTRYPOINT ["bash", "-l"]
