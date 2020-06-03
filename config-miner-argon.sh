#!/usr/bin/env bash
# Script created 2020-06-02 by WhoaBuddy
# Revised on 2020-06-03 for ARGON (Phase 2)
# Hosted on GitHub by AbsorbingChaos
# Link: https://github.com/AbsorbingChaos/bks-setup-miner
# Based on Bash3 Boilerplate. Copyright (c) 2014, kvz.io
# Link: https://kvz.io/blog/2013/11/21/bash-best-practices/

###############
# INIT SETUP  #
###############

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

# download argon miner config file from GitHub repo
curl -L https://raw.githubusercontent.com/AbsorbingChaos/bks-setup-miner/master/argon-miner-conf.toml --output ~/stacks-blockchain/testnet/stacks-node/conf/argon-miner-conf.toml

# replace seed with privateKey from keychain
sed -i "s/replace-with-your-private-key/`jq -r '.keyInfo .privateKey' ~/keychain.json`/g" ./stacks-blockchain/testnet/stacks-node/conf/argon-miner-conf.toml

# check the tBTC balance before starting the miner
# otherwise those UTXOs might not exist!
echo '{"id":"stacks","jsonrpc":"2.0","method":"listunspent","params":[0,9999999,["replace-with-btc-address"],false,{"minimumAmount":"0.00000001"}]}' > ~/checkbalance.json
sed -i "s/replace-with-btc-address/`jq -r '.keyInfo .btcAddress' ~/keychain.json`/g" ~/checkbalance.json

until curl -v --data-binary '@checkbalance.json' -H 'content-type:text/plain;' "http://None:None@35.245.47.179:18443" | grep amount; do
  printf 'tBTC balance not found - checking again in 3min - this is a good time to get coffee!'
  sleep 180
done

# change working directory to stacks-blockchain repo
cd ~/stacks-blockchain

# start the miner!
cargo testnet start --config ./testnet/stacks-node/conf/argon-miner-conf.toml
