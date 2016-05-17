apt-get update
apt-get upgrade -y
apt-get install -y git build-essential libssl-dev curl
curl https://raw.githubusercontent.com/creationix/nvm/v0.25.0/install.sh | bash
source ~/.bashrc
nvm install 0.12
nvm use 0.12
nvm alias default 0.12
cd ~
mkdir shb
cd shb
git clone https://github.com/frk1/steamhourboost.git ~/shb
npm install .
npm install -g coffee-script forever
