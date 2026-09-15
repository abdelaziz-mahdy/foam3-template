#!/bin/bash
#
# Runs this application on a fresh VM, for example an Oracle Cloud Always
# Free Ampere A1 instance (Ubuntu or Oracle Linux). Run once as a user with
# sudo; afterwards the container starts with the machine and keeps its
# journals in a Docker volume.
#
#   curl -fsSL https://raw.githubusercontent.com/abdelaziz-mahdy/foam3-template/main/deployment/oracle/setup.sh | bash
set -e

REPO=${REPO:-https://github.com/abdelaziz-mahdy/foam3-template}
APP=${APP:-example}
PORT=${PORT:-80}

# Docker, from Docker's own repository so the VM's distro version does not matter.
if ! command -v docker >/dev/null; then
  curl -fsSL https://get.docker.com | sudo sh
  sudo usermod -aG docker "$USER"
fi

# The VM's own firewall; the subnet's security list must also allow the port.
if command -v firewall-cmd >/dev/null; then
  sudo firewall-cmd --permanent --add-port=${PORT}/tcp && sudo firewall-cmd --reload
elif command -v iptables >/dev/null; then
  sudo iptables -I INPUT 6 -m state --state NEW -p tcp --dport ${PORT} -j ACCEPT
  sudo netfilter-persistent save 2>/dev/null || true
fi

# Build from the repository; the Dockerfile clones foam3 itself when the
# submodule is missing.
sudo rm -rf /opt/${APP}-src
sudo git clone --depth 1 "$REPO" /opt/${APP}-src
cd /opt/${APP}-src
sudo docker build -t ${APP} .

# Replace a previous container, keep the journal volume.
sudo docker rm -f ${APP} >/dev/null 2>&1 || true
sudo docker run -d --name ${APP} --restart unless-stopped \
  -p ${PORT}:8080 \
  -v ${APP}-journals:/opt/${APP}/journals \
  -v ${APP}-documents:/opt/${APP}/documents \
  -v ${APP}-logs:/opt/${APP}/logs \
  ${APP}

echo "started; open http://$(curl -s ifconfig.me 2>/dev/null || hostname -I | awk '{print $1}'):${PORT}"
