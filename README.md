# Setting up a Blockstack Miner

This repository contains a setup script to help automate (and hopefully simplify) the installation process outlined in my blog post:

[Step 2: Running a Miner Node (Zero to Testnet Series)](https://app.sigle.io/whoabuddy.id.blockstack/Lqq5_aeI1A06l_FQ8s9Jv)

Youtube video of the process: https://www.youtube.com/watch?v=VcqrxFW9HEQ

## Requirements

Before starting, you will need to install Virtualbox and set up a virtual machine running Ubuntu Server. The specifications I used are listed below, and more information on this process can be found in the first part of my blog series:

[Step 0: Virtualbox + Ubuntu (Zero to Testnet Series)](https://app.sigle.io/whoabuddy.id.blockstack/6ZSqK6yEwu5bqqGCjOZZH)

![Screenshot from 2020-06-02 09-21-11](https://user-images.githubusercontent.com/9038904/83544659-1b291580-a4b3-11ea-8ec9-ffb2cf16d52c.png)

## Setup and Usage

Once you have a virtual machine up and running with Ubuntu server, the script in this repository is designed to walk through the steps of setting up a miner node, including:

1. install prerequisites
2. install nvm
3. install node via nvm
4. install rust
5. clone stacks-blockchain repo
6. create a keychain including privateKey and btcAddress
7. request tBTC from faucet using btcAddress from keychain
8. pause for 60 seconds to allow transfer of tBTC from faucet
9. download argon miner config file
10. replace seed with privateKey from keychain
11. start the miner!

To run the script, you can either [download it manually](https://github.com/AbsorbingChaos/bks-setup-miner/blob/master/config-miner-argon.sh), or use curl:

```
curl -o- https://raw.githubusercontent.com/AbsorbingChaos/bks-setup-miner/master/config-miner-argon.sh | bash
```

## Final Word

Please note that this script is released under the [MIT License](LICENSE), and designed to be run on a freshly installed virtual machine. __Please only run this script on a virtual machine setup for the purpose of mining on the Blockstack Testnet, and please do not run this script on any system used in production.__

__*THIS IS FOR TESTING PURPOSES ONLY!*__
