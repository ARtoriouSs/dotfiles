# use Linux Mint 21 "Vanessa"
FROM linuxmintd/mint21-amd64

# emulate snap disabling on Mint
RUN touch /etc/apt/preferences.d/nosnap.pref

# create a non-root user
RUN sudo adduser test --gecos "Test" --disabled-password
RUN echo "test:test" | chpasswd
RUN usermod -aG sudo test

COPY . /home/test/dotfiles
# comment to leave current temp_settings in place
RUN rm -f /home/test/dotfiles/system/temp_settings.sh
RUN sudo chown -R test /home/test/dotfiles

USER test
WORKDIR /home/test/dotfiles
