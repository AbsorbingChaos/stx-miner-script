# Step 1: Preparations and Prerequisites

## Virtualbox Configuration

1. Create a new VM

Name: Stacks-Miner-Testnet
Base Memory: 2048 MB
Hard Drive: 400 GB
Network: Bridged Adapter

Only ~40gb should be needed for Bitcoin testnet, but the larger size is only used as the disk expands, so it's nice to leave extra room for switching to a mainnet configuration later.

1. Download [Ubuntu Server 20.04](https://ubuntu.com/download/server)

Option 3: Manual install
Download Ubuntu Server 20.04.1 LTS
914mb ISO file

1. Setup VM with Ubuntu Server

Add ISO under Storage settings and walk through installation.
Use full disk (400gb virtual set up earlier)
Install OpenSSH when prompted
Setup user info (will use for SSH later)

- u: whoabuddy
- p: (password)

## Ubuntu Server Configuration

1. Test login with credentials

2. Find IP address
`ip addr | grep ipv4`

3. Test SSH login with credentials
`ssh user@ipaddress`

4. Apply updates
`sudo apt-get update && sudo apt-get -y upgrade`

## Installing Bitcoin Core Software

1. Download [Bitcoin Core software](https://bitcoin.org/en/download)

`curl -O https://bitcoin.org/bin/bitcoin-core-0.20.1/bitcoin-0.20.1-x86_64-linux-gnu.tar.gz`

`tar xzf bitcoin-0.20.1-x86_64-linux-gnu.tar.gz`

`sudo install -m 0755 -o root -g root -t /usr/local/bin bitcoin-0.20.1/bin/*`

## Managing Bitcoin Core Software

`bitcoind -testnet -daemon`

`bitcoin-cli -testnet` options:

- getblockchaininfo
- getnetworkinfo
- getnettotals
- getwalletinfo
- stop
- help

From Diwaker for `bitcoin.conf`:

```toml
server=1
rpcuser=blah
rpcpassword=blahblah
testnet=1
txindex=0
listen=1
rpcserialversion=0
maxorphantx=1
banscore=1
[test]
bind=0.0.0.0:18333
rpcbind=0.0.0.0:18332
rpcport=18332
```

From Diwaker, to run `bitcoind`:

```bash
bitcoin-cli  -rpcport=18332 -rpcuser=blah -rpcpassword=blahblah importaddress <YOUR WALLET ADDRESS>
```

From Diwaker, for the config file:

```toml
[burnchain]
chain = "bitcoin"
mode = "xenon"
peer_host = "127.0.0.1"
username = "blah"
password = "blahblah"
rpc_port = 18332
peer_port = 18333
```

From the blog post, for the config file:

```toml
[node]
rpc_bind = "0.0.0.0:20443"
p2p_bind = "0.0.0.0:20444"
bootstrap_node = "047435c194e9b01b3d7f7a2802d6684a3af68d05bbf4ec8f17021980d777691f1d51651f7f1d566532c804da506c117bbf79ad62eea81213ba58f8808b4d9504ad@xenon.blockstack.org"

[burnchain]
chain = "bitcoin"
mode = "xenon"
peer_host = "bitcoind.xenon.blockstack.org"
username = "blockstack"
password = "blockstacksystem"
rpc_port = 18332
peer_port = 18333
```

## Progress Updates

Testing out how long it takes to get this information synced up.

- 20201130 1330 "verificationprogress": 0.0009465461777096446
- 20201130 1430 "verificationprogress": 0.3317282095865377
- 20201130 1730 "verificationprogress": 0.6902567328154868
- 20201130 1830 "verificationprogress": 0.7806625317495047
- 20201130 1930 "verificationprogress": 0.8471650418970854
- 20201130 2050 "verificationprogress": 0.9156050069358155
- 20201130 2145 "verificationprogress": 0.9612134948278437
- 20201130 2315 "verificationprogress": 0.9999999373107098,
  "initialblockdownload": false

While waiting:

- followed script to install everything
- created bitcoin.conf, stopped server, started again
- tested rpc connection via bitcoin-cli
- created xenon-miner-conf.toml
- copied keychain loaded with testnet btc

Originally created the keychain with @stacks/cli, but imported address using wif generated from stacks-gen, used the `--phrase` option to import.

`bitcoin-cli -testnet -rpcport=18332 -rpcuser=replace-with-your-btc-user -rpcpassword=replace-with-your-btc-password -rpcclienttimeout=7200 importprivkey "wif-string-from-stacks-gen"`

Others reported success with `importaddress` and the BTC address, haven't tested.

Typing all that rpc info each time is a lot. Created a function to act as an alias:

```bash
# function to simplify using bitcoin-cli
bitcoin-cli-wb() {
  # prefills testnet and rpc port info
  bitcoin-cli -testnet -rpcport=18332 -rpcuser=replace-with-your-btc-user -rpcpassword=replace-with-your-btc-password "$@"
}
```

Usage:

`bitcoin-cli-wb getblockchaininfo`
`bitcoin-cli-wb getwalletinfo`
`bitcoin-cli-wb stop`
