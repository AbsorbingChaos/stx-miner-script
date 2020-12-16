<!-- TOC -->

# Table of Contents

- [Table of Contents](#table-of-contents)
  - [Setting up a Miner Node](#setting-up-a-miner-node)
  - [Requirements](#requirements)
  - [Using the Script](#using-the-script)
  - [Using the Script: Debug Mode](#using-the-script-debug-mode)
  - [Examples / More Info](#examples--more-info)
    - [Blockchain Status](#blockchain-status)
    - [Live Demonstration](#live-demonstration)
    - [Virtual Machine Setup](#virtual-machine-setup)
  - [Final Word](#final-word)

<!-- /TOC -->

## Setting up a Miner Node

[![Testnet Phase Krypton Badge](https://img.shields.io/static/v1?label=Stacks%202.0%20Testnet%20Phase&message=%233%20Krypton&color=9cf&style=for-the-badge)](http://whenmainnet.co)

This repo contains a simple shell script that will help you set up and run a Miner Node on the [Stacks 2.0 Testnet](https://testnet.blockstack.org/).

*Note: the code was updated on 2020/12/15 to run the correct configuration for the [Daemon Technologies Mining Competition](https://daemontechnologies.co/minestx-challenge).*

*Note: The Xenon phase is not supported by this repository (yet).*

## Requirements

This script is designed for and tested with [Ubuntu Server 20.04 LTS](https://ubuntu.com/server).

In theory, it should work for any Ubuntu-based installation but [YMMV](https://dictionary.cambridge.org/us/dictionary/english/ymmv).

If you run into an error, please [file an issue](https://github.com/AbsorbingChaos/bks-setup-miner/issues) with more information.

## Using the Script

**To run the script**, simply use the command below.

```bash
curl -sS -o- https://raw.githubusercontent.com/AbsorbingChaos/bks-setup-miner/master/config-miner-krypton.sh | bash
```

It will download the file from this repository and run it via `bash`.

To stop the script or the miner (once it's running), press `CTRL+C` on Linux, or `COMMAND+.` on MacOS.

The script can be run multiple times, and will complete the following tasks:

1. Install or update operating system prerequisites
    - `build-essential cmake libssl-dev pkg-config jq git bc`
2. Detect or install node version manager (nvm)
3. Detect or install Node.js (via nvm)
4. Detect or install Rust (via rustup.rs)
5. Download or update the stacks-blockchain repository (via git)
6. Check out the 24.0.0.0-xenon tagged release for Krypton (via git)
7. Detect or create the keychain file (via blockstack-cli make_keychain)
8. Detect or request test BTC balance (via keychain file and faucet)
9. Detect or download miner configuration file (via GitHub)
    - If downloaded, automatically inserts the private key (via keychain file)
10. Check test BTC balance before starting the miner process
11. Start the miner and try to win the sortitions!

This link will allow you to [manually view or download the script](https://github.com/AbsorbingChaos/bks-setup-miner/blob/master/config-miner-krypton.sh), as well as [the node configuration file](https://github.com/AbsorbingChaos/bks-setup-miner/blob/master/krypton-miner-conf.toml), if you are into that kind of thing.

## Using the Script: Debug Mode

**To run the script in debug mode**, there are a few extra steps involved, but it provides a lot of useful information and records the screen output to a file that can be used to report to the team or file an issue on GitHub.

**Note:** The log file can grow *really fast* in this mode, so if leaving running for more than one day, be sure to double-check you have enough free space.

First, download the script:

```bash
curl -sS -O https://raw.githubusercontent.com/AbsorbingChaos/bks-setup-miner/master/config-miner-krypton.sh
```

Second, run the script with the `debug` option:

```bash
bash config-miner-krypton.sh debug
```

In addition to the tasks listed above, this will:

1. Delete and download a new copy of the stacks-blockchain repository (via git)
2. Record the output of `cargo start` using the `script` command, to a file named `bks-miner-YYYYMMDD-HHMMSS.txt`
3. Run `cargo start` with the environment variables `BLOCKSTACK_DEBUG=1` and `RUST_BACKTRACE=full`

This file contains a copy of all the terminal output seen on the screen, and is saved if the miner crashes or when the miner is stopped.

## Examples / More Info

### Blockchain Status

To view the status of the blockchain, click the link below.

http://status.test-blockstack.com/

### Live Demonstration

To view a live demonstration of the setup for Virtualbox, Ubuntu Server, and usage of the script, check out the video below!

- [Stacks 2.0 Miner Script Demo](https://www.youtube.com/watch?v=Lz1VSlIbMiE)

### Virtual Machine Setup

Before running the script, I recommend setting up a virtual machine using [Virtualbox](https://www.virtualbox.org/).

A step by step walkthrough of installing Virtualbox and setting up the Ubuntu Server virtual machine can be found at the link below as part of the [Zero to Testnet Blog Series](https://app.sigle.io/whoabuddy.id.blockstack/):

- [Step 0: Virtualbox + Ubuntu (Zero to Testnet Series)](https://app.sigle.io/whoabuddy.id.blockstack/6ZSqK6yEwu5bqqGCjOZZH)

The specifications I used for my Ubuntu Server virtual machine are listed and pictured below:

- Base Memory: 2048 MB (2gb RAM)
- Video Memory: 16 MB
- Hard Drive: 100 GB
- Network: Bridged Adapter

## Final Word

Please note that this script is released under the [MIT License](LICENSE). __Please only run this script on a virtual machine setup for the purpose of mining on the Blockstack Stacks 2.0 Testnet, and please do not run this script on any system used in production.__

__*THIS IS FOR TESTING PURPOSES ONLY!*__

If you run into any issues with the script or have any general questions about the process, feel free to [file an issue here](https://github.com/AbsorbingChaos/bks-setup-miner/issues), or reach out to me via the [Blockstack Discord channel](https://community.blockstack.org/discord) @whoabuddy.
