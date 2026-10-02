# use Linux Mint 22.2 "Zara" (same as the host system)
FROM linuxmintd/mint22.2-amd64

# host UID/GID, so the container user can use the host X display
ARG UID=1000
ARG GID=1000

# emulate snap disabling on Mint
RUN touch /etc/apt/preferences.d/nosnap.pref

# runtime for GUI apps forwarded to the host display (chrome/electron) and X diagnostics
# the image ships Ubuntu's base-files, so it identifies as Ubuntu and Mint's add-apt-repository refuses PPAs,
# Mint's base-files restores the real system identity (/etc/os-release)
RUN apt-get update && apt-get install --yes --allow-downgrades --no-install-recommends base-files/zara \
      xauth x11-apps x11-utils x11-xserver-utils mesa-utils dbus-x11 \
      libnss3 libgbm1 libasound2t64 libgtk-3-0t64 libxss1 libxkbfile1 libsecret-1-0 \
      fonts-dejavu xdg-utils ca-certificates wget curl \
    && rm -rf /var/lib/apt/lists/*

# create a non-root user (noble images ship "ubuntu" on uid 1000)
RUN userdel -r ubuntu 2> /dev/null || true
RUN groupadd --gid $GID test
RUN adduser test --uid $UID --gid $GID --gecos "Test" --disabled-password
RUN echo "test:test" | chpasswd
RUN usermod -aG sudo test

COPY . /home/test/dotfiles
# comment to leave current temp_settings in place
RUN rm -f /home/test/dotfiles/system/temp_settings.sh
RUN chown -R test:test /home/test/dotfiles

USER test
WORKDIR /home/test/dotfiles
