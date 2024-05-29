# We need to start from somewhere
FROM kalilinux/kali-rolling:latest
ENV DEBIAN_FRONTEND noninteractive

# Bring everything up to date
RUN apt update; apt -y dist-upgrade

# Install whatever we desire
RUN apt -y install \
zsh \
sudo
# I need xll-tools

# Here you can run additional commands to configure the box
# Create our new user and add it to some groups
RUN useradd -G sudo stargazer -s /bin/zsh -m
RUN usermod -aG sudo stargazer
# Create a default password so we can login
RUN echo "stargazer:stargazer" | chpasswd

# Clean up packages
RUN apt-get -y autoremove

# Jump to the shell
ENTRYPOINT zsh $@
