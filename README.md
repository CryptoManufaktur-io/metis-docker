# Overview

metis-replica-node, adjusted to work with central-proxy-docker

`cp default.env .env`, adjust the L1 RPC to your own Ethereum node, and `./metisd up`

The Ethereum node need not be an archive, but should have full eth_getLogs and tx indexing. For Geth
`--history.transactions=0` and for Nethermind `--Receipt.TxLookupLimit=0`.

The l2geth needs to be `GCMODE=archive` if using the snapshot provided by Metis. `l2geth.env` sets it that way
by default.

This is Metis Docker v1.0.0
