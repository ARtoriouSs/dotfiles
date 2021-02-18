# use Ubuntu 20.04
FROM amd64/ubuntu:focal

# prerequirements
RUN apt update && apt install -y sudo git

# emulate snap disabling
RUN touch /etc/apt/preferences.d/nosnap.pref

# emulate display
ENV DISPLAY :0

# create a non-root user
RUN sudo adduser test --gecos "Test" --disabled-password
RUN echo "test:test" | chpasswd
RUN usermod -aG sudo test

COPY . /home/test/dotfiles
RUN rm -f /home/test/dotfiles/system/temp_settings.sh
RUN sudo chown -R test /home/test/dotfiles

USER test
WORKDIR /home/test/dotfiles
