#!/usr/bin/env/bash

# Let's try abusing the faucet a little bit
# to see how the rate limiting works :)

set -o errexit
set -o pipefail
set -o nounset

# grab address from keychain file
__btcAddr=$(jq -r '.keyInfo .btcAddress' $HOME/keychain.json)
printf '\n%s' "BTC Address: $__btcAddr"

# show previous BTC balance
__btcBal=$(curl -sS "https://stacks-node-api.krypton.blockstack.org/extended/v1/faucets/btc/$__btcAddr" | jq -r .balance)
printf '\n%s' "BTC Balance Before: $__btcBal"

# request BTC from faucet
__btcReq=$(curl -sS -X POST https://stacks-node-api.krypton.blockstack.org/extended/v1/faucets/btc\?address\=$__btcAddr | jq -r .success)
printf '\n%s' "BTC Faucet Call Success: $__btcReq"

# pause
printf '\n%s' "(sleep 60s before checking balance)"
sleep 60

# show current BTC balance
__btcBal=$(curl -sS "https://stacks-node-api.krypton.blockstack.org/extended/v1/faucets/btc/$__btcAddr" | jq -r .balance)
printf '\n%s\n\n' "BTC Balance After: $__btcBal"

