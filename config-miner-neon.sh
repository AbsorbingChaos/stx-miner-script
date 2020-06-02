#!/usr/bin/env bash
# Script created 2020-06-02 by WhoaBuddy
# Hosted on GitHub by AbsorbingChaos
# Link: https://github.com/AbsorbingChaos/bks-setup-miner
# Based on Bash3 Boilerplate. Copyright (c) 2014, kvz.io
# Link: https://kvz.io/blog/2013/11/21/bash-best-practices/

###############
# INIT SETUP  #
###############https://raw.githubusercontent.com/AbsorbingChaos/bks-setup-miner/upd/scripts/config-miner-neon.sh

set -o errexit
set -o pipefail
set -o nounset

# install prerequisites
sudo apt-get install -y build-essential cmake libssl-dev pkg-config jq

# install nvm
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
# shellcheck source=src/.nvm/nvm.sh
source $HOME/.nvm/nvm.sh
# shellcheck source=src/.bashrc
source $HOME/.bashrc

# install node via nvm
nvm install node

# install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
# shellcheck source=src/.cargo/env
source $HOME/.cargo/env

# clone stacks-blockchain repo
git clone https://github.com/blockstack/stacks-blockchain.git ~/stacks-blockchain

# create a keychain including privateKey and btcAddress
npx blockstack-cli@1.1.0-beta.1 make_keychain -t > ~/keychain.json

# request tBTC from faucet using btcAddress from keychain
# note: usually takes 1-2 min to complete, so we will sleep for 1min
curl -X POST https://sidecar.staging.blockstack.xyz/sidecar/v1/faucets/btc\?address\="`jq -r '.keyInfo .btcAddress' ~/keychain.json`"
sleep 60

# download neon miner config file
# hosted on whoabuddydesign.com using Runkod for now
curl -L https://whoabuddydesign.com/neon-miner-conf.toml --output ~/stacks-blockchain/testnet/stacks-node/conf/neon-miner-conf.toml

# replace seed with privateKey from keychain
sed -i "s/replace-with-your-private-key/`jq -r '.keyInfo .privateKey' keychain.json`/g" ./stacks-blockchain/testnet/stacks-node/conf/neon-miner-conf.toml

# change working directory to stacks-blockchain repo
cd ~/stacks-blockchain

# start the miner!
cargo testnet start --config ./testnet/stacks-node/conf/neon-miner-conf.toml
