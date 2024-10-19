FROM kasmweb/kali-rolling-desktop:1.14.0
USER root

ENV HOME /home/kasm-default-profile
ENV STARTUPDIR /dockerstartup
ENV INST_SCRIPTS $STARTUPDIR/install
WORKDIR $HOME

######### Customize Container Here ###########

# RUN apt update && apt upgrade
# Install OpenVPN 
RUN apt-get update && \ 
    apt-get install -y openvpn

#Install tools easily with APT
RUN apt update && apt -y install dirbuster \
dirsearch burpsuite ffuf \
iputils-ping hashcat sliver \
nano seclists pip netcat-traditional \
peass wordlists dnsutils netcat-traditional freerdp2-x11 \
proxychains smbmap

# Netexec install
RUN sudo apt install pipx git
RUN pipx ensurepath
RUN pipx install git+https://github.com/Pennyw0rth/NetExec

RUN pip install git+https://github.com/guelfoweb/knock.git

RUN apt-get update \
    && apt-get install -y sudo \
    && echo 'kasm-user ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers \
    && rm -rf /var/lib/apt/list/*

######### End Customizations ###########

RUN chown 1000:0 $HOME
RUN $STARTUPDIR/set_user_permission.sh $HOME

ENV HOME /home/kasm-user
WORKDIR $HOME
RUN mkdir -p $HOME && chown -R 1000:0 $HOME

USER 1000
